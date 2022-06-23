require 'rails_helper'

RSpec.describe Auth::ValidateUserFromTokenService, type: :service do
  subject { described_class.new('Bearer', token) }

  describe '#call' do
    let!(:user) { create(:user) }

    context 'with correct token' do
      let(:token) { user.auth_token }

      it 'returns user' do
        user = subject.call
        expect(user).to eq(user)
      end
    end

    context 'with incorrect token' do
      let(:token) { 'wrong-auth-token' }

      it 'raises unauthencated error' do
        expect { subject.call }.to raise_error(APIError::NotAuthenticatedError)
      end
    end
  end
end
