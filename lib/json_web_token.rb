class JsonWebToken
  def self.encode(data, exp = 1.months.from_now)
    payload = { data: data, exp: exp.to_i }
    JWT.encode(payload, secret)
  end

  def self.decode(token)
    ActiveSupport::HashWithIndifferentAccess.new(JWT.decode(token, secret).first)
  end

  def self.secret
    ENV['JWT_SECRET'] || 'jwtsecret'
  end

  private_class_method :secret
end
