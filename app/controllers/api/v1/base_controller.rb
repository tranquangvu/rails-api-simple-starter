module API
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!

      attr_reader :current_user

      private

      def authenticate_user!
        scheme, token = request.headers['Authorization']&.split(' ')
        @current_user = Auth::ValidateUserFromTokenService.call(scheme, token)
      end
    end
  end
end
