# coding: utf-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def zaim
    @user = User.find_or_create_user_by_zaim_oauth(request.env["omniauth.auth"], current_user) # 最初current_userはnil
    if @user.persisted?
      sign_in_and_redirect @user #NOTE:commentout  , :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Zaim") if is_navigational_format?
    else
      #session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path #new_user_registration_url
    end
  end
end
