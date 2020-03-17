Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  controller :registration do
    get 'signup', to: 'registration#new'
    post 'signup', to: 'registration#create'
    get :verification
  end

  resources :users, only: [:update , :edit ,:show, :index] do
    get 'profile', to: 'users#show_profile'
    get 'home', to: :home
    resources :follows, only: [:update, :destroy]
    resources :questions
    member do
      patch :mark_all_as_seen
    end
  end

  scope :v1 do
    resources :questions, param: :identifier, path: :asks, as: :stories
  end

  match '/update_votes' => 'votes#update', via: :get

  # resources :answers, only: [:new, :create]
  resources :answers

  controller :comments do
    get 'new_comment' => :new
    post :create_comment
  end

  resources :notifications, only: [:update]

  controller :purchase_credits do
    get 'offers' => :new
    post 'get_credits' => :create
  end

  resources :report_abuses, only: :create

  resources :topics, only: [:index, :show]

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
  direct :homepage do
    "https://rubyonrails.org"
  end

  direct :commentable do |model|
    [ model, anchor: model.dom_id ]
  end

  direct :main do
    { controller: "pages", action: "index", subdomain: "www" }
  end

  # get '*path', to: redirect('/')
end
