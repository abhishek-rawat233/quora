Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  controller :registration do
    get 'signup', to: 'registration#new'
    post 'signup', to: 'registration#create'
    get :verification
  end

  resources :charges, only: [:new, :create]

  resources :users, only: [:update , :edit ,:show, :index] do
    get 'profile', to: 'users#show_profile'
    get 'home', to: :home
    get 'credits', to: :credits
    post 'purchase_credits', to: :purchase_credits
    get :transaction_history
    resources :follows, only: [:update, :destroy]
    resources :questions
    member do
      patch :mark_all_as_seen
    end
  end

  match '/update_votes' => 'votes#update', via: :get

  resources :answers, only: [:new, :create]

  controller :comments do
    get 'new_comment' => :new
    post :create_comment
  end

  resources :notifications, only: [:update]

  # controller :purchase_credits do
  #   get 'offers' => :new
  #   post 'get_credits' => :create
  # end

  resources :report_abuses, only: :create

  resources :topics, only: [:index, :show]

  controller :sessions do
    get 'login' => :new
    post 'login' => :login
    delete 'logout' => :logout
    root 'sessions#welcome'
    get 'forgotPassword' => :forgot_password_form
    post 'forgotPassword' => :forgot_password
    get 'resetPassword' => :reset_password_form
    post 'resetPassword' => :reset_password
  end

  mount StripeEvent::Engine, at: '/payments'
  # get '*path', to: redirect('/')
end
