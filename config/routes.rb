Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :registration do
    get '/signup', to: 'registration#new'
    post '/signup', to: 'registration#create'
  end

  resources :users, only: [] do
    # member do
      get 'profile', to: 'users#profile'
      get 'profile/edit', to: 'users#edit_profile'
      post 'profile/edit', to: 'users#update_profile'
      get 'questions', to: 'users#questions'
      get 'questions/:title/edit', to: 'users#edit_question'
      delete 'questions/:title', to: 'users#delete_question'
    # end
  end

  controller :user_feeds do
    get 'home', to: :home
  end

  get '/verification', to: 'registration#verification'

  resources :questions do
    member do
      get ':id', to: 'questions#show'
      get 'new', to: :new
      post 'create', to: :create
    end
  end
  # resources :questions, param: :title , only: :show

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
end
