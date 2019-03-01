Rails.application.routes.draw do
  resources :doctors, only: %i[index show new create specialties] do
    resources :consultations, only: %i[new create]
    resources :reviews, only: %i[index new create]
  end
  devise_for :users
  resources :users do
    resources :consultations, only: %i[index show]
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'pages#about'
end

