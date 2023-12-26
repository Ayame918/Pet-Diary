# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController

  # def create # ユーザー認証を行い、リソースを取得
  #   self.resource = warden.authenticate!(auth_options) # ログイン成功時のフラッシュメッセージを設定
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)  # ユーザーをサインインさせる

  # end

  # def destroy # ログアウトする
  #   sign_out(resource_name)
  #   set_flash_message! :notice, :signed_out if signed_in? # ログアウト成功時のフラッシュメッセージを設定
  # end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

   protected

  def after_sign_in_path_for(resource)
    admin_posts_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
