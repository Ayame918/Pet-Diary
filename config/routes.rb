Rails.application.routes.draw do
  get 'public/tags'
  devise_for :users, skip: [:passwords], controllers: {
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
    resources :tags, only: [:index, :show]
    resources :bookmarks, only: [:index, :create, :destroy]
    #resources :comments, only: [:create, :destroy]
    #resources :favorites, only: [:create, :destroy]
    #resources :posts, only: [ :index, :show, :create, :edit, :update]
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    devise_scope :user do
      resources :users, only: [:index, :show, :edit] do
        collection do
          get 'my_page', action: 'mypage'
          patch 'update_my_page', to: 'users#update', as: 'update_user'
          patch :withdraw
        end
      end

      post "user/guest_sign_in", to: "sessions#guest_sign_in"

    end

    #resource :session, only: [:new, :create, :destroy]



    resource :relationships, only: [:create, :destroy]
    get "user_followings" => "relationships#followings", as: "user_followings"
    get "user_followers" => "relationships#followers", as: "user_followers"
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
