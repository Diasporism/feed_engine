class ProvidersController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    current_user.providers.create(name: auth['provider'], uid: auth['uid'])
    redirect_to root_path
  end

  def destroy
    provider = current_user.providers.find(params[:id])
    provider.delete
    redirect_to root_path
  end

end
