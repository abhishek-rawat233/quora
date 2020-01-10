Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  controller :registration do
    get 'signup', to: 'registration#new'
    post 'signup', to: 'registration#create'
    get :verification
  end

  resources :users, only: [:update , :edit ,:show] do
    resources :questions
    member do
      patch :mark_all_as_seen
    end
  end

  controller :user_feeds do
    get :home
  end

  match '/update_votes' => 'votes#update', via: :put

  resources :answers, only: [:new, :create]

  resources :votes, only: :update

  controller :comments do
    get 'new_comment' => :new
    post :create_comment
  end

  resources :notifications, only: [:update]

  controller :sessions do
    get 'login' => :new
    post 'login' => :login
    delete 'logout' => :destroy
    root 'sessions#welcome'
    get 'forgotPassword' => :forgot_password_form
    post 'forgotPassword' => :forgot_password
    get 'resetPassword' => :reset_password_form
    post 'resetPassword' => :reset_password
  end

  # get '*path', to: redirect('/')
end
