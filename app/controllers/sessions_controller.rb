class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    raise auth.to_yaml
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    session[:oauth_token] = nil
    redirect_to root_url, notice: "Signed out!"
  end

end

