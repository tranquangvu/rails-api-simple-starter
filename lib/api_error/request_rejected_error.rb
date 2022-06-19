module APIError
  class RequestRejectedError < StandardError
    def initialize(message = nil)
      super(
        status: '422',
        title: 'Unprocessable Entity',
        detail: message || 'The change you wanted was rejected'
      )
    end
  end
end
