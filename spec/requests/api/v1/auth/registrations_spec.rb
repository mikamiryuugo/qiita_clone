require 'rails_helper'

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }
    let(:params) { attributes_for(:user) }
    context do
      it "Userのレコードが作成できる" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(200)
      end
    end
  end
end