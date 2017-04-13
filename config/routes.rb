Rails.application.routes.draw do
  devise_for :users
  resources :meetings
  resources :books
  resources :users
  post '/notes', to: 'notes#create'
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
