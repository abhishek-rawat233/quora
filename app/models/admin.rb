class Admin < BaseUser
  def make_user_disabed(user_id)
    user = @BaseUser.find_by(id: user_id)
    user.set_api_token
    user.update(status: :disabled)
  end
end
