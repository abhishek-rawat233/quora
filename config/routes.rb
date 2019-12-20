Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :registration do
    get '/signup', to: 'registration#new'
    post '/signup', to: 'registration#create'
  end

  resources :user do
    get '/profile', to: 'user#profile'
    get '/profile/edit', to: 'user#edit_profile'
    match '/profile/edit', to: 'user#update_profile', via: [:patch, :put, :post]
  end

  get '/verification', to: 'registration#verification'

  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
    get 'welcome', to: 'session#welcome'
    get 'forgotPassword' => :forgot_password_form
    post 'forgotPassword' => :forgot_password
    get 'resetPassword' => :reset_password_form
    post 'resetPassword' => :reset_password
  end

end
