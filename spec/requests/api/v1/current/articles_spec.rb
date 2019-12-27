require "rails_helper"

RSpec.describe "Current/Articles", type: :request do
  describe "GET current/articles" do
    let!(:user) {create(:user)}
    let!(:article1) { create(:article, :published, user_id: user.id) }
    let!(:article2) { create(:article, :published, user_id: user.id) }
    let!(:article3) { create(:article, :published, user_id: user.id) }
    let!(:article4) { create(:article, user_id: user.id) }
    let(:headers) { authentication_headers_for(user) }

    context "ログインしている時" do
      it "自分が書いた公開記事の一覧が取得できる" do
        get(api_v1_current_articles_path, headers: headers)

        res = JSON.parse(response.body)

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(res.length).to eq 3
          expect(res.map {|d| d["id"] }).to eq [article1.id, article2.id, article3.id]
          expect(res[0].keys).to eq ["id", "title","content", "updated_at", "status", "user"]
          expect(res[0]["user"].keys).to include "id", "name", "email"
        end
      end
    end

    context "ログインしていない時" do
      it "自分が書いた公開記事の一覧が取得できない" do
        get(api_v1_current_articles_path)
        expect(response).to have_http_status(401)
      end
    end
  end
end