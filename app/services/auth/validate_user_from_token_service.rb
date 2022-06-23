module Auth
  class ValidateUserFromTokenService < ApplicationService
    attr_reader :scheme, :token

    def initialize(scheme, token)
      @scheme = scheme
      @token = token
    end

    def call
      user = User.find_by(id: decoded_token&.dig(:data, :user_id))
      (scheme == 'Bearer' && user) || raise(APIError::NotAuthenticatedError)
    end

    private

    def decoded_token
      @decoded_token ||= decode_token(@token)
    end

    def decode_token(token)
      JsonWebToken.decode(token)
    rescue JWT::VerificationError, JWT::DecodeError
      nil
    end
  end
end
