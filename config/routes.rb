Rails.application.routes.draw do
  resources :sessions, only:[:new,:create]
  get '/logout', to: 'sessions#destroy', as: :session_destroy
  resources :users
  get '/(:day)', to: 'users#dashboard'
  root to: 'users#dashboard'
end
