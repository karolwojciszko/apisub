class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :require_login
  #rescue_from Exception do |e|
  	#return render :json => Settings.getError(no).to_json, :status => Settings.getError(no)["status"]
  	#error(1)
    #error2 = Settings.getError(1)
   	#puts(error2)
   #return render :json => error2.to_json, :status => error2["status"]
    #redirect_to :controller => 'general', :action => 'error', :id => no and return
    #error(1)
  #end

  def get_user
     redirect_to :controller => 'general', :action => 'error', :id => 1 and return
     #return render json: params[:token].to_json
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  protected
  def error(no)
    return render :json => Settings.getError(no).to_json, :status => Settings.getError(no)["status"]
    #redirect_to :controller => 'general', :action => 'error', :id => no and return
    #return render :json => Settings.getError(no).to_json, :status => Settings.getError(no)["status"]
  end

  protected
    def auth_user
		params.fetch(:token)
    end

end
