class SessionsController < ApplicationController

  def create

    auth = request.env["omniauth.auth"]
    session[:auth] = auth
    user = User.new(email: auth['info']['email'])
    if user.save
      auto_login(User.find_by_email(user.email))
      redirect_to add_provider_path
    else
      auto_login(User.find_by_email(user.email))
      redirect_to root_path
    end


    info = request.env["omniauth.auth"]
    user_email = request.env["omniauth.auth"][:info][:email]
    user_token = request.env["omniauth.auth"][:credentials][:token]
    # session[:oauth_token] = info["credentials"]["token"]
    # session[:oauth_secret] = info["credentials"]["secret"]
    # user = User.create_from_omniauth(env["omniauth.auth"])
    provider = Provider.construct(user, info)
    session[:user_id] = user.id
    session[:provider_id] = provider.id
    redirect_to root_url
  end

  def destroy
    logout
    redirect_to root_path, notice: "Signed out!"
  end
end

