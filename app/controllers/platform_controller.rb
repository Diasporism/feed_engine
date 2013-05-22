class PlatformController < ApplicationController
  before_filter :require_login, only: [:index]

  def index
    timeline = Platform.new(current_user).timeline
    
    @timeline = Kaminari.paginate_array(timeline).page(params[:page]).per(10) if timeline
  end

  def splash
    @params = params
    render :layout => false
  end
end
