module Auth
  class RequestAuthenticateUserService < ApplicationService
    attr_reader :scheme, :token

    def initialize(headers)
      @scheme, @token = headers['Authorization']&.split(' ')
    end

    def call
      user = User.find_by(id: decoded_token&.dig('data', 'user_id'))
      raise APIError::NotAuthenticatedError if scheme != 'Bearer' || !user.present?

      user
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
