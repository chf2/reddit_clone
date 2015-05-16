Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/edit'

  get 'posts/show'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts do
    resources :comments, only: [:new]
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :comments, only: [:create, :show] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end
