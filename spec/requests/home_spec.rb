require 'rails_helper'

RSpec.describe "Home API", type: :request do
  describe "GET /" do
    let(:user) { User.create!(email: 'david@testing.com', password: 'testing', password_confirmation: 'testing') }

    subject { get "/", nil, {'Authorization' => "Bearer #{token}"} }

    context "with valid token" do
      let(:token) { TokenProcessor.encode_auth_token(user) }

      it "succeeds" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json).to eq("data" => "Hello World")
      end
    end

    context "with invalid token" do
      let(:token) { "invalid_token" }

      it "fails" do
        subject

        expect(response).to have_http_status(:unauthorized)
        expect(json).to eq("error" => "The token is invalid")
      end
    end

    context "with expired token" do
      let(:token) { TokenProcessor.encode_auth_token(user, exp: 1.minute.ago.to_i) }

      it "fails" do
        subject

        expect(response).to have_http_status(:unauthorized)
        expect(json).to eq("error" => "The token is expired")
      end
    end
  end
end
