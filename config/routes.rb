Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/edit'

  get 'posts/show'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts
end
