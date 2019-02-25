Rails.application.routes.draw do
  resources :consultations, only: [:index, :show, :new]
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
