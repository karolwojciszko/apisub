class TvguideController < ApplicationController
  def get
  	begin
		auth_user
	rescue Exception => e
   		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
	end

  	if params[:start].nil?
  		filterDate = Time.now.to_s
  	else
  		filterDate = params[:start]
  	end

  	token = Token.where(:token => params[:token]).first

  	if token.nil? || token.expired <= Time.now
		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
  	end

  	return render :json => Tvguide.guidetv_get(filterDate)
  end

  private
    def auth_user
		params.fetch(:token)
    end
end
