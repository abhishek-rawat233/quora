require 'rails_helper'

describe UsersController, type: :controller do
  subject { create :last_rspec, verified: true }
  
  before do
    session[:api_token] = subject.api_token
  end

  
  describe 'GET user#EDIT profile' do
    before do
      get :edit, params: { id: subject.id }
    end

    it "renders edit profile" do
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET user#HOME' do
    before do
      get :home, params: { user_id: subject.id }
    end
    it "renders home page" do
      expect(response).to render_template("home")
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
      # question = double("question", title: 'first one', content: 'in a while', question_type: 'published')
    
      get 'index'
    end
    it 'renders index' do
      expect(response.header['Content-Type']).to include 'application/json'
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

  describe 'get profile image' do
    it do
      user = double(User)
      allow(user).to receive(:get_profile_image) { 'image' }
      expect(user.get_profile_image).to eq('image')
    end
  end

  describe 'question_ids' do
    it do
      allow(subject).to receive(:question_ids) {[1,2,3,4]}
      expect(subject.question_ids).to eq([1,2,3,4])
    end
  end
end