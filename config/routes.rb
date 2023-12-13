Rails.application.routes.draw do

  devise_for :users,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  resources :videos
  scope module: :public do
    root to: 'homes#top'

    get 'relationship/follower'
    get 'relationship/followed'

    resources :followings, only: [:create, :destroy]
    resources :tags, only: [:index, :create]
    resources :bookmarks, only: [:index, :create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]

    resources :users, only: [:index, :show, :edit, :update] do
      get "mypage" => "users#mypage", on: :member
      get "withdraw" => "users#withdraw", on: :member
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    resource :session, only: [:new, :create, :destroy]
    resource :registrations, only: [:new, :create]
  end

  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'

    get 'tags/index'
    get 'tags/edit'
    get 'tags/update'

    get 'posts/index'
    get 'posts/show'

    get 'homes/top'

    resource :sessions, only: [:new, :create, :destroy]
  end


end
