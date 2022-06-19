module APIError
  class NotAuthenticatedError < StandardError
    def initialize(message = nil)
      super(
        status: '401',
        title: 'Unauthorized',
        detail: message || 'You are not authenticated to perform this request'
      )
    end
  end
end
