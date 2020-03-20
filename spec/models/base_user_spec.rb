require 'rails_helper'

RSpec.describe BaseUser, type: :model do

  subject { create(:last_rspec) }
  let!(:question) { create :first_question, base_user: subject, author: subject }
  let(:fir_not) { create :first_noti, base_user: subject, question: question }
  let!(:disabledUser) { create(:disabled_user) }
  let!(:another_user) { build(:last_after_last_rspec) }
  let!(:yui) { build :first_after_last_rspec }

  describe 'validation testing' do
    let!(:new_user) { build(:empty_user) }
    before { new_user.valid? }
    context 'ensures errors presence' do
      it { expect(new_user.errors).to be }
    end

    context 'ensures email presence' do
      it { expect(new_user.errors[:email]).to include "can't be blank" }
    end

    it { expect(subject).to validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { is_expected.to have_secure_password }
    it { expect(another_user).to allow_value("loll@oll.ol").for(:email) }
    it { is_expected.to validate_presence_of(:password_digest).on(:create) }
    it { expect(yui).to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_confirmation_of(:password).on(:create) }

  end

  context 'association testing' do
    # it { is_expected.to validate_attachment_of :image }
    it { is_expected.to have_many(:user_favorite_topics).dependent(:destroy) }
    it { is_expected.to have_many(:topics).through(:user_favorite_topics) }
    it { is_expected.to have_many(:related_questions).through(:topics).source(:questions) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:report_abuses).dependent(:destroy) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:follows) }
    it { is_expected.to have_many(:follower_relationships).with_foreign_key('following_id').class_name('Follow') }
    it { is_expected.to have_many(:followers).through(:follower_relationships).source(:follower).dependent(:destroy) }
    it { is_expected.to have_many(:following_relationships).with_foreign_key('base_user_id').class_name('Follow') }
    it { is_expected.to have_many(:followings).through(:following_relationships).source(:following).dependent(:destroy) }
    it { is_expected.to have_many(:all_questions).through(:followings).source(:questions) }
  end

  context 'callbacks testing' do
    it { is_expected.to callback(:set_api_token).before(:create) }
    it { is_expected.to callback(:set_credits).before(:save).if(:verified_changed?).if(:verified?) }
    it { is_expected.to callback(:set_verification_token).after(:create) }
    it { is_expected.to callback(:send_verification_mail).after(:create) }
    it { is_expected.to callback(:check_cust).after(:cust_callb) }
  end

  context 'public instance methods' do
    it { expect(subject).to respond_to(:check_cust) }
    it { expect(subject.check_cust).to eq("running") }
    it { expect(subject.unseen_notifications).to include(fir_not) }
    it { expect(subject).to respond_to(:set_api_token) }
    it { expect(subject.api_token).to eq(subject.api_token) }

    context "update password" do
      before { subject.update_password('whyShouldI') }
      it { expect(subject.authenticate('whyShouldI')).to eq(subject) }
    end
    it { expect(subject.validate_password('lololol')).to eq(subject) }
    it { expect(subject).to respond_to(:verify) }
    context "verify user" do
      before { subject.verify }
      it { expect(subject.verified).to eq true }
    end

    it { expect(subject).to respond_to(:set_credits) }
    it { expect(subject.set_credits).to eq DEFAULT_CREDITS }
    it { expect(subject).to respond_to(:increment_credits) }
    context "increment credits" do
      before do
        subject.verify
        subject.increment_credits
      end
      it { expect(subject.credits).to eq(6) }
    end
    it { expect(subject).to respond_to(:decrement_credits) }
    context "decrement credits" do
      before do
        subject.verify
        subject.decrement_credits
      end
      it { expect(subject.credits).to eq(4) }
    end
  end

  context 'private methods testing' do
    it { expect(subject.send(:set_verification_token)).to eq true }
  end

  describe 'scope testing' do
    context ".active status" do
      it { expect(BaseUser.active).to include(subject) }
    end
    
    context ".disabled status" do
      it { expect(BaseUser.disabled).to include(disabledUser) }
    end
  end
end
