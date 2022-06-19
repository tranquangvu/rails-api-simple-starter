module APIError
  class RecordInvalidError < StandardError
    def initialize(errors = []) # rubocop:disable Lint/MissingSuper
      @errors = errors
      @status = '422'
      @title = 'Unprocessable Entity'
    end

    def serializable_hash
      errors.reduce([]) do |memo, error|
        memo << {
          title: title,
          detail: error.full_message,
          status: status,
          source: { pointer: "/data/attributes/#{error.attribute}" }
        }
      end
    end

    private

    attr_reader :errors
  end
end
