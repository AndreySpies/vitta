Rails.application.routes.draw do
  resources :admins, only: %i[edit update]
  resources :doctors, only: %i[index show new create specialties] do
    resources :consultations, only: %i[new create]
    resources :reviews, only: %i[index new create]
  end
  get 'patients', to: 'doctors#patients'
  devise_for :users
  post '/consultations/confirm_consultation', to: 'consultations#confirm_consultation', as: :confirm_consultation
  resources :users do
    resources :consultations, only: %i[index show]
    resources :patient_records, only: %i[index new create]
    # get '/medical_records', to: 'medical_records#show'
    # get '/medical_records/edit', to: 'medical_records#edit', as: :edit_medical_records
  end
  resources :patient_records, only: %i[edit update]
  resources :medical_records, only: %i[show edit update]
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'pages#about'
  get 'test', to: 'pages#test'
end

