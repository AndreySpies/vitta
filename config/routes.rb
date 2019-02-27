Rails.application.routes.draw do
  resources :doctors, only: %i[index show new create] do
    resources :consultations, only: %i[index show new create]
  end
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'pages#about'
end
