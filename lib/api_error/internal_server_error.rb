module APIError
  class InternalServerError < StandardError
    def initialize(message = nil)
      super(
        status: '500',
        title: 'Internal Server Error',
        detail: message || 'We encountered unexpected error, but our developers had been already notified about it'
      )
    end
  end
end
