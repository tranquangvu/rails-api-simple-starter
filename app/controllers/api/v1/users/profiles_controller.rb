module API
  module V1
    module Users
      class ProfilesController < BaseController
        def me
          render_resource(current_user)
        end
      end
    end
  end
end
