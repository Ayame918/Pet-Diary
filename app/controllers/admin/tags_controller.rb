class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.page(params[:page]).per(15)
  end
  
  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to admin_tags_path
  end
end
