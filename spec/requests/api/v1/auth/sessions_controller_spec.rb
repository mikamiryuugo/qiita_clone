require 'rails_helper'

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }
    let!(:user) {create(:user)}
    let(:params) { { email: user.email, password: user.password } }
    #正常系
    context do
      it "トークンを取得できる" do
        subject
        headers = response.headers

        aggregate_failures do

          expect(response).to have_http_status(:ok)
          expect(headers["access-token"]).to be_present
          expect(headers["client"]).to be_present
          expect(headers["expiry"]).to be_present
          expect(headers["uid"]).to be_present
          expect(headers["token-type"]).to be_present
        end
      end
    end

    #異常系
    context "送るemailが誤りの時" do
      let(:params) { { email: "000_#{Faker::Internet.email}", password: user.password } }

      it "トークン情報を取得できない" do
        subject
        headers = response.headers

        aggregate_failures do
          expect(response).to have_http_status(:unauthorized)
          expect(headers["access-token"]).to be_blank
          expect(headers["client"]).to be_blank
          expect(headers["expiry"]).to be_blank
          expect(headers["uid"]).to be_blank
          expect(headers["token-type"]).to be_blank
        end
      end
    end

    context "送るpasswordが誤りの時" do
      let(:params) { { email: user.email, password: "dammy-password" } }

      it "トークン情報を取得できない" do
        subject
        headers = response.headers

        aggregate_failures do
          expect(response).to have_http_status(:unauthorized)
          expect(headers["access-token"]).to be_blank
          expect(headers["client"]).to be_blank
          expect(headers["expiry"]).to be_blank
          expect(headers["uid"]).to be_blank
          expect(headers["token-type"]).to be_blank
        end
      end
    end
  end


  describe "DELETE /api/v1/auth/sign_out" do

    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    context "ログイン済みのユーザーの情報を送ったとき" do
      let(:user) { create(:user) }
      #authentication_headers_for(user)はヘルパー
      let!(:headers) { authentication_headers_for(user) }

      it "トークン情報が削除される" do
        aggregate_failures do
          expect { subject }.to change { user.reload.tokens }.from(be_present).to(be_empty)

          res = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(res["success"]).to be true
        end
      end
    end
  end
end