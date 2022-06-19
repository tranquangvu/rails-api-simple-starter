module Auth
  class AuthenticateUserService < ApplicationService
    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: email)
      raise APIError::NotAuthenticatedError.new('Invalid email or password') if !user.present? || !user.authenticate(password)

      user
    end
  end
end
