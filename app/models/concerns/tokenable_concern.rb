module TokenableConcern
  def generate_token(attribute)
    token = SecureRandom.urlsafe_base64
    while User.exists?(attribute => token)
      token = SecureRandom.urlsafe_base64
    end
    token
  end
end
