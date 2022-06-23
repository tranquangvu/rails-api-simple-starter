module API
  module V1
    module Users
      class RegistrationsController < BaseController
        skip_before_action :authenticate_user!, only: :create

        def create
          user = Auth::RegisterUserService.call(user_params)
          render_resource(user, serializer: AuthUserSerializer, status: :created)
        end

        private

        def user_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
