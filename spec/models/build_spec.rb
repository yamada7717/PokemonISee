require 'rails_helper'

RSpec.describe Build, type: :model do
  let(:user) { create(:user) }
  let(:build) { create(:build, user: user) }

  describe '#valid' do
    context '新規登録が成功する場合' do
      it '属性が有効の場合' do
        expect(build.valid?).to eq true
      end
    end

    context '新規登録が失敗する場合' do
      it 'タイトルがない場合は無効' do
        build.title = nil
        build.valid?
        expect(build.errors[:title]).to include('を入力してください')
      end

      it 'タイトルが20文字を超える場合は無効' do
        build.title = 'a' * 21
        build.valid?
        expect(build.errors[:title]).to include('は20文字以内で入力してください')
      end

      it '紹介文が2000文字を超える場合は無効' do
        build.introduction = 'a' * 2001
        build.valid?
        expect(build.errors[:introduction]).to include('は2000文字以内で入力してください')
      end

      it 'シーズンがない場合は無効' do
        build.season = nil
        build.valid?
        expect(build.errors[:season]).to include('を入力してください')
      end

      it 'バトルタイプがない場合は無効' do
        build.battle_type = nil
        build.valid?
        expect(build.errors[:battle_type]).to include('をどちらか選択してください')
      end

      it '公開設定が設定されていない場合は無効' do
        build.is_public = nil
        build.valid?
        expect(build.errors[:is_public]).to include('をどちらか選択してください')
      end
    end
  end
end
