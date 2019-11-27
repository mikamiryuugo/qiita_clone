require 'rails_helper'

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }
    let(:params) { attributes_for(:user) }
    #正常系
    context do
      it "Userのレコードが作成できる" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(200)
      end
    end

    #異常系
    context "emailが送信されない時" do
      let(:params) { attributes_for(:user).slice(:name, :password) }
      it "Userのレコードが作成できない" do
        expect { subject }.to change { User.count }.by(0)
      end
    end

    context "passwordが送信されない時" do
      let(:params) { attributes_for(:user).slice(:name, :email) }
      it "Userのレコードが作成できない" do
        # binding.pry
        expect { subject }.to change { User.count }.by(0)
      end
    end

    context "同一のアドレスが登録されている時" do
      let!(:user) {create(:user)}
      let(:params) { attributes_for(:user, email: user.email).slice(:name, :email, :password) }

      it "Userのレコードが作成できない" do
        expect { subject }.to change { User.count }.by(0)
      end
    end
  end
end