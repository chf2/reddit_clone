Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/edit'

  get 'posts/show'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show]
end
