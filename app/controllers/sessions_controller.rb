class SessionsController < ApplicationController

  def create
    info = request.env["omniauth.auth"]
    session[:oauth_token] = info["credentials"]["token"]
    session[:oauth_secret] = info["credentials"]["secret"]
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    session[:oauth_token] = nil
    redirect_to root_url, notice: "Signed out!"
  end

end

