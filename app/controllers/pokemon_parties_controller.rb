class PokemonPartiesController < ApplicationController
  before_action :require_login
  before_action :set_build, only: %i[new edit create]
  def new
    return if params[:search].blank?

    search_query = params[:search].tr('　', ' ').strip.gsub(/\s+/, '')

    if search_query.length < 2
      redirect_to new_build_pokemon_party_path, notice: '検索結果が得られませんでした'
      return
    end

    matched_pokemons = Pokemon.where('japanese_name LIKE ?', "%#{search_query}%")
    @pokemon_parties = []

    if matched_pokemons.present?
      matched_pokemons.each do |pokemon|
        english_name = pokemon.english_name.downcase
        raw_response = Faraday.get "https://pokeapi.co/api/v2/pokemon/#{english_name}"
        if raw_response.success?
          response = JSON.parse(raw_response.body)
          @pokemon_party = PokemonParty.new(
            pokemon_id: pokemon.id,
            pokemon_image_url: response["sprites"]["front_default"],
            build_id: params[:build_id]
          )
          @pokemon_parties.push(@pokemon_party)
        else
          flash[:alert] = "ポケモンデータの取得に失敗しました。"
          redirect_to new_build_pokemon_party_path
          break
        end
      end
    else
      flash[:alert] = "該当するポケモンが見つかりませんでした。"
      redirect_to new_build_pokemon_party_path
    end
    @items = Item.all.map { |item| [item.japanese_name, item.id] }
  end

  def edit
    @pokemon_parties = @build.pokemon_parties
  end

  def create
    @pokemon_party = @build.pokemon_parties.new(pokemon_party_params)

    if @pokemon_party.item_id.blank?
      flash[:alert] = "アイテムを選択してください。"
      redirect_to new_build_pokemon_party_path(build_id: @build.id) and return
    end

    item = Item.find(@pokemon_party.item_id)
    item_english_name = item.english_name.downcase

    item_response = Faraday.get "https://pokeapi.co/api/v2/item/#{item_english_name}"
    if item_response.success?
      item_data = JSON.parse(item_response.body)
      @pokemon_party.item_image_url = item_data['sprites']['default']
    else
      flash.now[:alert] = "アイテムの取得に失敗しました。"
      render :new
    end

    if @pokemon_party.save
      redirect_to build_path(@build), notice: 'ポケモンが追加されました。'
    else
      flash[:alert] = @pokemon_party.errors.full_messages.to_sentence
      redirect_to new_build_pokemon_party_path(build_id: @build.id)
    end
  end

  def update
  end

  private

  def set_build
    @build = Build.find(params[:build_id])
  end

  def pokemon_party_params
    params.require(:pokemon_party).permit(:pokemon_id, :item_id, :pokemon_image_url, :item_image_url, :build_id)
  end
end
