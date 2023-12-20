class Public::BookmarksController < ApplicationController
    before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）
  
  def index
    # 特定の投稿に関連するブックマーク一覧を取得
    @post = Post.find(params[:post_id])
    @bookmarks = @post.bookmarks
  end

  # お気に入り登録
  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.post_bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
  # お気に入り削除
  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.post_bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?#２度押しのエラーを回避
        bookmark.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end

end