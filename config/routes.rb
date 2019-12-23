Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :registration do
    get '/signup', to: 'registration#new'
    post '/signup', to: 'registration#create'
  end

  resources :base_user do
    get '/profile', to: 'base_user#profile'
    get '/profile/edit', to: 'base_user#edit_profile'
    match '/profile/edit', to: 'base_user#update_profile', via: [:patch, :put, :post]
  end

  get '/verification', to: 'registration#verification'


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  controller :sessions do
    get 'welcome', to: 'sessions#welcome'
    get 'forgotPassword' => :forgot_password_form
    get 'resetPassword' => :reset_password_form
    delete 'logout' => :destroy
    post 'forgotPassword' => :forgot_password
    post 'resetPassword' => :reset_password
  end

end
