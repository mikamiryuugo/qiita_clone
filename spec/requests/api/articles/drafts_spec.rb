require "rails_helper"

RSpec.describe "Drafts", type: :request do
  describe "GET /drafts/index" do
    let!(:user) {create(:user)}
    let!(:article)  { create(:article, user_id: user.id) }
    let!(:article2) { create(:article, user_id: user.id) }
    let!(:article3) { create(:article, :published, user_id: user.id) }

    context "ログインしている時" do
      let(:headers) { authentication_headers_for(user) }
      it "下書き記事の一覧が取得できる" do
        get(api_v1_articles_drafts_path, headers: headers)
        expect(user.articles.draft.count).to eq 2
      end
    end

    context "ログインしていない時" do

      it "下書き記事の一覧が取得できない" do
        get (api_v1_articles_drafts_path)
        expect(response).to have_http_status(401)
      end
    end

  end
end
