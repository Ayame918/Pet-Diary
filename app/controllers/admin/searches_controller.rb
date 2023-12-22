class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @user = User.where("name LIKE?","%#{@word}%").page(params[:page]).per(8)
    else
      @posts = Post.where("post_content LIKE?","%#{@word}%").page(params[:page]).per(8)
      render 'search'
    end
  end
end
