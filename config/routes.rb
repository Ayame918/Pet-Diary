Rails.application.routes.draw do
  get 'public/tags'
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: 'homes#top'
     get "admin/search" => "searches#search"
    resources :users, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :edit, :update]
    resources :posts, only: [:index, :show]
  end

  resources :videos

  scope module: :public do
    root to: 'homes#top'

    resources :tags, only: [:index, :show]
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:index, :create, :destroy] do
        get 'post_bookmarks', to: 'bookmarks#index', as: 'user_bookmarks'
      end
    end

    devise_scope :user do
      resources :users, only: [:index, :show, :edit] do
        collection do
          get 'my_page', action: 'mypage'
          patch 'update_my_page', to: 'users#update', as: 'update_user'
          patch :withdraw
        end
        resource :relationships, only: [:create, :destroy]
        	get "followings" => "relationships#followings", as: "followings"
        	get "followers" => "relationships#followers", as: "followers"
        	
        	member do
            # ブックマークした一覧
            get :bookmark_posts
          end
      end

      post "user/guest_sign_in", to: "sessions#guest_sign_in"
  end


    resource :sessions, only: [:new, :create, :destroy]
  end

end
