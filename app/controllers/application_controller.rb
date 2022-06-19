class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend

  include JSONAPIRender
  include ExceptionFilter
end
