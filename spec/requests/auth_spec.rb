require 'rails_helper'

RSpec.describe "Auth API", type: :request do
  let(:user) { User.create!(email: 'david@testing.com', password: 'testing', password_confirmation: 'testing') }

  describe "POST /auth/login" do
    let(:email) { user.email }

    subject { post "/auth/login", {data: {email: email, password: password}} }

    context "with valid email and password" do
      let(:password) { user.password }

      it "succeeds" do
        subject

        byebug

        expect(response).to have_http_status(:ok)
        expect(json['data']['token']).to be_present
      end
    end

    context "with invalid email and password" do
      let(:password) { 'invalid_password' }

      it "fails" do
        subject

        expect(response).to have_http_status(:unauthorized)
        expect(json).to eq("error" => "Invalid email or password")
      end
    end
  end

  describe "POST /auth/reset_password" do
    let(:password) { user.password }
    let(:password_confirmation) { password }

    subject { post "/auth/reset_password", {data: {token: token, password: password, password_confirmation: password_confirmation}} }

    context "with valid token and new password" do
      let(:token) { TokenProcessor.encode_reset_password_token(user) }

      it "succeeds" do
        subject

        expect(response).to have_http_status(:ok)
        expect(json).to eq("data" => "OK")
      end
    end

    context "with expired token" do
      let(:token) { TokenProcessor.encode_reset_password_token(user, exp: 1.day.ago.to_i) }

      it "fails" do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq("error" => "Token is expired")
      end
    end

    context "with wrong token sub" do
      let(:token) { TokenProcessor.encode_auth_token(user) }

      it "fails" do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq("error" => "Token is invalid")
      end
    end
  end
end
