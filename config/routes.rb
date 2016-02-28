Rails.application.routes.draw do
  resources :sessions, only:[:new,:create]
  get '/logout', to: 'sessions#destroy', as: :session_destroy
  resources :users
  namespace :admin do
    get '/',         to: 'users#index'
    get 'users/export', to: 'users#export', as: :users_export
    get 'users/import', to: 'users#import', as: :users_import
    post'users/import', to: 'users#import'
    get 'users/search', to: 'users#search', as: :users_search
    post'users/search', to: 'users#search'
    resources :users
  end
  get '/(:day)', to: 'users#dashboard'
  root to: 'users#dashboard'
end
