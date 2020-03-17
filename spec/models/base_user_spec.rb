require 'rails_helper'

RSpec.describe BaseUser, type: :model do

  subject { create(:last_rspec) }
  let(:another_user) { build(:last_after_last_rspec) }

  context 'validation testing' do
    it 'ensures errors presence' do
      user = BaseUser.create
      expect(user.errors).to be
    end

    it 'ensures email presence' do
      user = BaseUser.create
      expect(user.errors[:email]).to include "can't be blank"
    end

    it 'ensures email uniqueness' do
      create(:last_rspec)
      user = BaseUser.create(email: 'lel@lel.lel')
      expect(user.errors[:email]).to include "has already been taken"
    end

    it { is_expected.to have_secure_password }
    it { expect(another_user).to allow_value("loll@oll.ol").for(:email) }
    it { is_expected.to validate_presence_of(:password_digest).on(:create) }
    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_confirmation_of(:password).on(:create) }

  end

  context 'association testing' do
    # it { is_expected.to validate_attachment_of :image }
    it { is_expected.to have_many(:user_favorite_topics).dependent(:destroy) }
    it { is_expected.to have_many(:topics).through(:user_favorite_topics) }
    it { is_expected.to have_many(:related_questions).through(:topics).source(:questions) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:report_abuses).dependent(:destroy) }
    # before {debugger}
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:follows) }
    it { is_expected.to have_many(:follower_relationships).with_foreign_key('following_id').class_name('Follow') }
    it { is_expected.to have_many(:followers).through(:follower_relationships).source(:follower).dependent(:destroy) }
    it { is_expected.to have_many(:following_relationships).with_foreign_key('base_user_id').class_name('Follow') }
    it { is_expected.to have_many(:followings).through(:following_relationships).source(:following).dependent(:destroy) }
    it { is_expected.to have_many(:all_questions).through(:followings).source(:questions) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
  # rspec on active storge
end
