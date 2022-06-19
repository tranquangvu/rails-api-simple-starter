module API
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!

      attr_reader :current_user

      def authenticate_user!
        @current_user = Auth::RequestAuthenticateUserService.call(request.headers)
      end
    end
  end
end
