Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :registration, path: :signup do
  end

  get '/verification', to: 'registration#verification'

end
