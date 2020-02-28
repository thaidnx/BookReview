class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'].provider, request.env['omniauth.auth'].uid, request.env['omniauth.auth'].extra.raw_info.name, request.env['omniauth.auth'].info.email, current_user)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Facebook'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'].provider, request.env['omniauth.auth'].uid, request.env['omniauth.auth'].extra.raw_info.name, request.env['omniauth.auth'].info.email, current_user)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end