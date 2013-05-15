class SessionsController < ApplicationController



  def create
    auth = request.env["omniauth.auth"]
    if auth["provider"] == 'google_oauth2'
      user = User.new(email: auth['info']['email'])
      if user.save
        user.providers.create(name: auth['provider'], uid: auth['uid'])
      end
      auto_login(User.find_by_email(user.email))
      redirect_to root_path, notice: "Signed in!"
    else

    end
  end

  def destroy
    logout
    redirect_to root_url, notice: "Signed out!"
  end
end

