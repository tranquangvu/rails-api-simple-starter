require 'rails_helper'

RSpec.describe 'authentications', type: :request do
  describe 'POST /api/v1/users/signup' do
    def do_request
      post api_v1_users_signup_path, params: { user: user_params }
    end

    context 'with valid params' do
      let(:user_params) { attributes_for(:user) }

      it 'returns created response' do
        expect { do_request }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:user_params) { attributes_for(:user, password: '') }

      it 'returns unprocessable entity response' do
        expect { do_request }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST /api/v1/users/login' do
    let!(:user) { create(:user, password: 'password123') }

    def do_request
      post api_v1_users_login_path, params: { user: user_params }
    end

    context 'with correct credentials' do
      let(:user_params) { { email: user.email, password: 'password123' } }

      it 'returns ok response with user' do
        do_request
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with incorrect credentials' do
      let(:user_params) { { email: user.email, password: 'wrongpassword' } }

      it 'returns unauthorized respoonse' do
        do_request
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/users/me' do
    let!(:user) { create(:user, password: 'password123') }

    def do_request
      get api_v1_users_me_path, headers: auth_api_headers(user)
    end

    it 'returns ok response with current user info' do
      do_request
      expect(response).to have_http_status(:ok)
    end
  end
end
