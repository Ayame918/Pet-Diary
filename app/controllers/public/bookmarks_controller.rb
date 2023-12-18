class Public::BookmarksController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）
  
  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  # お気に入り登録
  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
  # お気に入り削除
  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?#２度押しのエラーを回避
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
