class AuthUserSerializer < UserSerializer
  set_type :user

  attribute :auth_token
end
