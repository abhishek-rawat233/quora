require 'rails_helper'

describe UsersController, type: :controller do
  subject { create :last_rspec, verified: true }
  
  before do
    session[:api_token] = subject.api_token
  end

  describe 'get profile image' do
    context 'method return value' do
      it do
        user = double(User)
        allow(user).to receive(:get_profile_image) { 'image' }
        expect(user.get_profile_image).to eq('image')
      end
    end
  end

  describe 'question_ids' do
    it do
      allow(subject).to receive(:question_ids) {[1,2,3,4]}
      expect(subject.question_ids).to eq([1,2,3,4])
    end
  end
  describe 'GET user#EDIT profile' do
    before do
      get :edit, params: { id: subject.id }
    end

    it "renders edit profile" do
      expect(response).to render_template(:edit)
      expect(assigns(:topics)).to eq Topic.all
    end
  end

  describe 'GET user#HOME' do
    before do
      get :home, params: { user_id: subject.id }
    end
    it "renders home page" do
      expect(response).to render_template("home")
      expect(assigns(:questions)).to eq Question.all.order(updated_at: :desc)
      expect(assigns(:user_following_ids)).to eq subject.following_ids
    end
  end

  describe 'GET user#SHOW' do
    before do
      get :show_profile, params: { user_id: subject.id }
    end
    it "renders show profile page" do
      expect(response).to render_template(:show_profile)
    end
  end

  describe 'GET user#INDEX' do
    before do
      get 'index'
    end
    it 'renders index' do
      expect(response.header['Content-Type']).to include 'application/json'
      expect(assigns(:user).association(:questions)).to be_loaded
    end
  end

  describe 'GET user#SHOW_PROFILE' do
    before do
      get 'show', params: { id: subject.id }
    end
    it { expect(response).to render_template("show") }
  end

  describe 'POST update' do
    before do
      session[:api_token] = subject.api_token
      put :update, params: { id: subject.id  }
    end

    it "redirects to user profile" do
      expect(response).to redirect_to(user_path)
    end

    it "flashes notice" do
      expect(flash[:notice]).to eq('successfully uploaded')
    end
  end
end