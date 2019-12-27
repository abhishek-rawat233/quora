Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :registration do
    get 'signup', to: 'registration#new'
    post 'signup', to: 'registration#create'
  end

  resources :users, only: [] do
    member do
      get 'profile'
      get 'profile/edit', to: 'users#edit_profile'
      post 'profile/edit', to: 'users#update_profile'
    end
  end

  get '/verification', to: 'registration#verification'

  controller :sessions do
    get 'login' => :new
    post 'login' => :login
    delete 'logout' => :destroy
    get 'welcome', to: 'sessions#welcome'
    get 'forgotPassword' => :forgot_password_form
    post 'forgotPassword' => :forgot_password
    get 'resetPassword' => :reset_password_form
    post 'resetPassword' => :reset_password
  end

end
