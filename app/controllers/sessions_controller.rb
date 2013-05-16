class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.new(email: auth['info']['email'])
    if user.save
      auto_login(User.find_by_email(user.email))
      redirect_to add_provider_path
    else
      auto_login(User.find_by_email(user.email))
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Signed out!"
  end
end

