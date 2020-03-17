require 'test_helper'

class BaseUserTest < ActiveSupport::TestCase

  userOptions = {
    email: 'agshd2s@dsa.com',
    password: 'sadasd',
    password_confirmation: 'sadasd',
    type: 'User',
    name: 'lol'
  }

  def setup
    # @user = build(:first)
    @userr = create(:first_after_last)
    @sec_user = build(:last)
  end

  test "the truth" do
    assert true, 'this is base user first test'
  end

  test "validations working?" do 
    user = BaseUser.new
    assert user.invalid?
  	assert user.errors[:email].any?
    assert user.errors[:password_digest].any?
    assert_not user.save, 'empty user no data provided'
  end

  test "unique email" do
    user = BaseUser.new(
  		name: "lolol",
  		password_digest: "loool",
      email: "lel@lel.lel"      
  		)
  	assert user.invalid?, 'user is valid'
  	assert_not_includes user.errors[:email], "has already been taken" #check this again
  end

  test 'email is valid' do
    assert_match EMAIL_VALIDATOR, "asds@sad.com", 'email 1 is invalid'
    assert_no_match EMAIL_VALIDATOR, "asd@aa", "email 2 is invalid"
    assert_no_match EMAIL_VALIDATOR, "asd", "email 3 is invalid"
    assert_no_match EMAIL_VALIDATOR, "", "email 4 is invalid"   
  end

  # test 'factory working?' do
  #   assert @user.valid?, @user.errors.full_messages.to_s
  # end

  # test 'answer association is working' do
  #   @sec_user.valid?
  #   puts "answers size is not same #{@sec_user.answers}.as_json"
  #   assert_equal 1, @sec_user.answers.size, "answers size is not same #{@sec_user.answers}.as_json"
  # end

end
