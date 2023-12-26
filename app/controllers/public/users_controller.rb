class Public::UsersController < ApplicationController

  def mypage
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    redirect_to my_page_users_path if @user == current_user
  end

  def index
    @users = User.all
    @users = User.page(params[:page]).per(12)

  end

  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      flash[:notice] = "編集する権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def create
    if @user.save
      flash[:notice] = '変更が保存されました。'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "変更に失敗しました。"
      render :edit
    end
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = '変更が保存されました。'
      redirect_to my_page_users_path
    else
      flash.now[:alert] = "変更に失敗しました。"
      render 'edit'
    end
  end

  def withdraw
    current_user.update(is_active: false)
    sign_out(current_user)
    redirect_to root_path
  end

  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      flash[:notice] =　"ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end 
  
  def liked_posts
    @bookmark_posts = Post.bookmark_posts(current_user, params[:page], 12)
  end

  def user_params
    params.require(:user).permit(:name,:profile_image, :introduction)
  end
  
end
