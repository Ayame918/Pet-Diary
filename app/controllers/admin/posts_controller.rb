class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "編集が成功しました。"
    else
      render :edit
    end
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @post.save_tags(params[:post][:tags])
      redirect_to admin_post_path(@post)
    else
      render :new
    end
  end
  
  def post_params
    params.require(:post).permit(:post_content, medias: [])
  end
  
end
