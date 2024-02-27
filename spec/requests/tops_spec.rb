require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "TOPページ" do
    it "TOPページのリクエストが正しい場合" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
