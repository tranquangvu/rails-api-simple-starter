class APIErrorSerializer
  attr_reader :error

  def initialize(error)
    @error = error
  end

  def to_h
    serializable_hash
  end

  def to_json(_options = {})
    to_h.to_json
  end

  private

  def serializable_hash
    { errors: Array.wrap(error.serializable_hash) }
  end
end
