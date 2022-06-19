class AuthUserSerializer < UserSerializer
  set_type :user

  attribute :auth_token do |user|
    JsonWebToken.encode(user_id: user.id)
  end
end
