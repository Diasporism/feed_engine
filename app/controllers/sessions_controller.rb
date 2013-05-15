class SessionsController < ApplicationController

  def create
    info = request.env["omniauth.auth"]
    user_email = request.env["omniauth.auth"][:info][:email]
    user_token = request.env["omniauth.auth"][:credentials][:token]
    raise user_token.inspect
    # session[:oauth_token] = info["credentials"]["token"]
    # session[:oauth_secret] = info["credentials"]["secret"]
    user = User.from_omniauth(env["omniauth.auth"])
    Provider.construct(user.id, info)
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
    session[:oauth_token] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end

