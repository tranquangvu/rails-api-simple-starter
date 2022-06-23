require 'rails_helper'

RSpec.describe Auth::LoginUserService, type: :service do
  subject { described_class.new(email, password) }

  describe '#call' do
    let(:email) { 'me@go.com' }
    let(:password) { 'password123' }

    context 'with correct credentials' do
      let!(:user) { create(:user, email: email, password: password) }

      it 'returns user' do
        user = subject.call
        expect(user).to eq(user)
      end
    end

    context 'with incorrect credentials' do
      it 'raises unauthencated error' do
        expect { subject.call }.to raise_error(APIError::NotAuthenticatedError)
      end
    end
  end
end
