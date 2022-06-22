module Auth
  class LoginUserService < ApplicationService
    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: email)
      user&.authenticate(password) || raise(APIError::NotAuthenticatedError, 'Invalid email or password')
    end
  end
end
