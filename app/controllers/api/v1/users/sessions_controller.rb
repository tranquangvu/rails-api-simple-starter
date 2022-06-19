module API
  module V1
    module Users
      class SessionsController < BaseController
        skip_before_action :authenticate_user!, only: :create

        def create
          user = Auth::AuthenticateUserService.call(user_params[:email], user_params[:password])
          render_resource(user, serializer: AuthUserSerializer)
        end

        private

        def user_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
