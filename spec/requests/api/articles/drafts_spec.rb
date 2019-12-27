require "rails_helper"

RSpec.describe "Drafts", type: :request do
  let!(:user) {create(:user)}
  let!(:article1)  { create(:article, user_id: user.id) }
  let!(:article2) { create(:article, user_id: user.id) }
  let!(:article3) { create(:article, :published, user_id: user.id) }
  let(:headers) { authentication_headers_for(user) }

  describe "GET /drafts/index" do
    context "ログインしている時" do
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

  describe "GET /drafts/:id" do
    let(:article_id) {article1.id}

    context "ログインしている時" do
      it "下書き詳細記事が取得できる" do
        get(api_v1_articles_draft_path(article_id), headers: headers)

        res = JSON.parse(response.body)

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(res["id"]).to eq article1.id
          expect(res["title"]).to eq article1.title
          expect(res["content"]).to eq article1.content
          expect(res["updated_at"]).to be_present
          expect(res["user"]["id"]).to eq article1.user.id
          expect(res["user"].keys).to include "id", "name", "email"
        end
      end
    end

    context "ログインしていない時" do
      it "下書き詳細記事が取得できない" do
        get(api_v1_articles_draft_path(article_id))
        expect(response).to have_http_status(401)
      end
    end

    context "指定した id の下書き記事が存在しない場合" do
      let(:article_id) { 10000 }

      it "記事が見つからない" do
        expect { get(api_v1_articles_draft_path(article_id), headers: headers) }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end
end
