require 'rails_helper'

RSpec.describe Auth::RegisterUserService, type: :service do
  subject { described_class.new(params) }

  describe '#call' do
    context 'with valid params' do
      let(:params) { attributes_for(:user) }

      it 'creates user' do
        result = nil
        expect { result = subject.call }.to change(User, :count).by(1)
        expect(result).to be_instance_of(User)
      end
    end

    context 'with invalid params' do
      let(:params) { attributes_for(:user, password: '') }

      it 'raises error and does not create user' do
        expect { subject.call }.to raise_error(ActiveRecord::RecordInvalid)
          .and(not_change(User, :count))
      end
    end
  end
end
