class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    session[:auth] = auth
    user = User.new(email: auth['info']['email'])

    if user.save
      auto_login(User.find_by_email(user.email))
      Resque.enqueue_in(1.minutes, TweetFetcher, :user_id => current_user.id)
      Resque.enqueue_in(10.seconds, EmailFetcher, :user_id => current_user.id)
      redirect_to add_provider_path
    else
      auto_login(User.find_by_email(user.email))
      Resque.enqueue_in(1.minutes, TweetFetcher, :user_id => current_user.id)
      Resque.enqueue_in(10.seconds, EmailFetcher, :user_id => current_user.id)
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Signed out!"
  end
end

