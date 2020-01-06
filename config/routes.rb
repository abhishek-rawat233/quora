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
    get 'home', to: :home
  end


  # resources :questions, only: [:new, :create, :edit, :show]

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

  get '*path', to: redirect('/')
end
