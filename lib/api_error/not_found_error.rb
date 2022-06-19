module APIError
  class NotFoundError < StandardError
    def initialize(message = nil)
      super(
        status: '404',
        title: 'Not Found',
        detail: message || 'The resource can not be found',
      )
    end
  end
end
