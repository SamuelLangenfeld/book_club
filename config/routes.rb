Rails.application.routes.draw do
  devise_for :users
  resources :meetings
  resources :books
  resources :users
  post '/notes', to: 'notes#create'
  patch '/note', to: 'notes#update'
  delete '/note', to: 'notes#destroy'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
