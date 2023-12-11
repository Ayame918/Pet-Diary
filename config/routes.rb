Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  namespace :admin do
    get 'tags/index'
    get 'tags/edit'
    get 'tags/update'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'relationship/follower'
    get 'relationship/followed'
  end
  namespace :public do
    get 'followings/create'
    get 'followings/destroy'
  end
  namespace :public do
    get 'tags/index'
    get 'tags/create'
  end
  namespace :public do
    get 'bookmarks/index'
    get 'bookmarks/create'
    get 'bookmarks/destroy'
  end
  namespace :public do
    get 'comments/create'
    get 'comments/destroy'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/show'
    get 'posts/destroy'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/mypage'
    get 'users/withdraw'
  end
  namespace :public do
    get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'
  end
  namespace :public do
    get 'registrations/new'
    get 'registrations/create'
  end
  namespace :public do
    get 'homes/top'
  end
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
