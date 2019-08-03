require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject { get(api_v1_articles_path) }

    before do
      create(:user, :with_articles)
    end

    it "articlesの一覧を取得できる" do
      subject
      res = JSON.parse(response.body).count
      expect(res).to eq 5
    end

  end
end
