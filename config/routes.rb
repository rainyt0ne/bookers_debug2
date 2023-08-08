Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about" => "homes#about"
  get "/search" => "searches#search"

  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
      get "follower_lists" => "relationships#follower_lists", as: "follower_lists"
      get "followed_lists" => "relationships#followed_lists", as: "followed_lists"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end