require "rails_helper"

RSpec.describe "Drafts", type: :request do
  describe "GET /drafts/index" do
    let!(:user) {create(:user)}
    let!(:article)  { create(:article, user_id: user.id) }
    let!(:article2) { create(:article, user_id: user.id) }
    let!(:article3) { create(:article, :published, user_id: user.id) }

    context "ログインしている時" do

      let(:params) { { email: user.email, password: user.password } }

      it "下書き記事の一覧が取得できる" do
        post(api_v1_user_session_path, params: params)
        headers = response.headers

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(headers["access-token"]).to be_present
          expect(headers["client"]).to be_present
          expect(headers["expiry"]).to be_present
          expect(headers["uid"]).to be_present
          expect(headers["token-type"]).to be_present
        end

        get (api_v1_drafts_index_path)
        expect(user.articles.draft.count).to eq 2
      end
    end

    context "ログインしていない時" do
      it "下書き記事の一覧が取得できない" do
        get (api_v1_drafts_index_path)
        expect(response).to have_http_status(401)
      end
    end

  end
end
