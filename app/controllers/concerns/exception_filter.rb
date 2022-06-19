module ExceptionFilter
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError,
                with: -> { render_api_error(APIError::NotAuthorizedError.new) }

    rescue_from ActiveRecord::RecordNotFound,
                with: -> { render_api_error(APIError::NotFoundError.new) }

    rescue_from ActiveRecord::RecordInvalid,
                with: ->(e) { render_api_error(APIError::RecordInvalidError.new(e.record.errors)) }

    rescue_from ActiveRecord::RecordNotDestroyed,
                with: ->(e) { render_api_error(APIError::RecordInvalidError.new(e.record.errors)) }

    rescue_from ActionController::ParameterMissing,
                with: ->(e) { render_api_error(APIError::ParamMissingError.new(e.param)) }
  end

  def render_api_error(error)
    render json: APIErrorSerializer.new(error), status: error.status
  end
end
