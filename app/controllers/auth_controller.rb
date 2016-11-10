class AuthController < ApplicationController

  def login
  	begin
		auth_login_params
	rescue Exception => e
   		return render :json => Settings.getError(2).to_json, :status => Settings.getError(2)["status"]
	end
	#passwd = 
	@user = User.where(username: params[:username], password: Digest::MD5.hexdigest(params[:password])).first

	if !@user.present?
		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	@token = Token.where(:user => @user).where("expired >= ?", Time.now).first

	updateExpirationTime = Time.now + Settings.getTokenValidationTime
	if @token.present?
		@token.expired = updateExpirationTime
		@token.save
		return render json: @token.to_json 
	else
		token = Token.new(:expired => updateExpirationTime, :user => @user)
		token.token = Digest::MD5.hexdigest(Time.now.to_s)
		token.save
		return render json: token.to_json 
	end
  end

  private
    def auth_login_params
		params.fetch(:username)
  		params.fetch(:password)
    end
end
