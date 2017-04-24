Rails.application.routes.draw do
  devise_for :users
  resources :meetings
  resources :books
  resources :users, only: [:show, :index]
  post '/notes', to: 'notes#create'
  patch '/note', to: 'notes#update'
  delete '/note', to: 'notes#destroy'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  post '/group_pics', to: 'group_pics#create'
  delete '/group_pics', to: 'group_pics#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
