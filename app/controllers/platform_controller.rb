class PlatformController < ApplicationController
  before_filter :require_login, only: [:index]

  def index
    platform = Platform.new(current_user)
    timeline = platform.timeline
    @timeline = Kaminari.paginate_array(timeline).page(params[:page]).per(10)
  end

  def splash
    @params = params
    render :layout => false
  end
end
