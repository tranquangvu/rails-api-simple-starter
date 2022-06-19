module APIError
  class NotAuthorizedError < StandardError
    def initialize(message = nil)
      super(
        status: '403',
        title: 'Forbidden',
        detail: message || 'You are not authorized to perform this request'
      )
    end
  end
end
