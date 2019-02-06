Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy] do 
    resources :posts, only: [:create, :new]
  end
  resources :posts, except: [:create, :index] do
    resources :comments, only: [:new]
    member do
      get 'upvote'
      get 'downvote'
    end
  end
  resources :comments, only: [:create, :destroy] do
    member do
      get 'upvote'
      get 'downvote'
    end
  end
end
