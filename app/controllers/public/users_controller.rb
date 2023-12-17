class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  def mypage
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    redirect_to my_page_users_path if @user == current_user
  end

  def index
    @users = User.all

  end

  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to user_path(current_user.id)
    else
     flash[:notice] = "編集する権限がありません"
    end
  end

  def create
    if @user.save
      flash[:notice] = "You have created a user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to my_page_users_path, notice: '変更が保存されました。'
    else
      render 'edit'
    end
  end

  def withdraw
    current_user.update(is_active: false)
    sign_out(current_user)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image, :introduction)
  end

end
