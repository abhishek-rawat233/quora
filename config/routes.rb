Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :registration do
    get '/signup', to: 'registration#new'
    post '/signup', to: 'registration#create'
  end

  resources :users do
    get '/profile', to: 'users#profile'
    get '/profile/edit', to: 'users#edit_profile'
    match '/profile/edit', to: 'users#update_profile', via: [:patch, :put, :post]
  end

  controller :user_feeds do
    get 'home', to: :home
    get 'ask_question', to: :ask_question
    post 'submit_question', to: :submit_question
  end

  get '/verification', to: 'registration#verification'

  resources :questions do
    get '/:id', to: 'questions#show'
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
