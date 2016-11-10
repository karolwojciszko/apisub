class SubscriptionController < ApplicationController
  def get
  	begin
		auth_user
	rescue Exception => e
   		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
	end

	token = Token.where(:token => params[:token]).first
	
	if token.nil? || token.expired <= Time.now
		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
  	end

  	user = User.find_by_id(Token.joins(:user).select("users.id"))

  	subscriptions = Subscription.where(:user => user)

  	return render :json => subscriptions.to_json
  end

  def addchannel
  	begin
		auth_user
	rescue Exception => e
   		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
	end

	begin
		channel_params
	rescue Exception => e
   		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	token = Token.where(:token => params[:token]).first
	
	if token.nil? || token.expired <= Time.now
		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
  	end

	channel = Channel.find_by_id(params[:channel_id])
	
	if channel.nil?
		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	user = User.find_by_id(Token.joins(:user).select("users.id"))

	shows = Show.where(:channel => channel)

	shows.each do |show|
		exist = Subscription.where(:user => user, :channel => channel, :show => show)
		if !exist.present?
			subscription = Subscription.new(:user => user, :channel => channel, :show => show)
			subscription.save
		end
	end

	return render :json => ["status":"true"].to_json
  end

  def addshow
  	begin
		auth_user
	rescue Exception => e
   		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
	end

	begin
		show_params
	rescue Exception => e
   		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	token = Token.where(:token => params[:token]).first
	
	if token.nil? || token.expired <= Time.now
		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
  	end

	show = Show.find_by_id(params[:show_id])
	
	if show.nil?
		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	user = User.find_by_id(Token.joins(:user).select("users.id"))

	if !show.channel_id.present?
		subscription = Subscription.where(:user_id => user, :show => show, :channel => nil).first
		
		if !subscription.nil?
			return render :json => Settings.getError(5).to_json, :status => Settings.getError(5)["status"]
		end

		subscription = Subscription.new(:user => user, :show => show)
		subscription.save
		return render :json => ["status":"true"].to_json
	else

		channel = Channel.find_by_id(show.channel_id)
		subscription = Subscription.where(:user_id => user, :channel => channel, :show => show).first
		#return render :json => subscription.to_json
		if !subscription.nil?
			return render :json => Settings.getError(5).to_json, :status => Settings.getError(5)["status"]
		end

		subscription = Subscription.new(:user => user, :channel => channel, :show => show)
		subscription.save

	  	return render :json => ["status":"true"].to_json
	end
  end

  def removechannel
  	begin
		auth_user
	rescue Exception => e
   		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
	end

	begin
		channel_params
	rescue Exception => e
   		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	token = Token.where(:token => params[:token]).first
	
	if token.nil? || token.expired <= Time.now
		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
  	end

	channel = Channel.find_by_id(params[:channel_id])
	
	if channel.nil?
		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	user = User.find_by_id(Token.joins(:user).select("users.id"))

	subscription = Subscription.where(:user_id => user, :channel => channel).first

	if subscription.nil?
		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	shows = Show.where(:channel => channel)
	shows.each do |show|
		exist = Subscription.where(:user => user, :channel => channel, :show => show).first
		if exist.present?
			exist.destroy
		end
	end

  	return render :json => ["status":"true"].to_json
  end

def removeshow
  	begin
		auth_user
	rescue Exception => e
   		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
	end

	begin
		show_params
	rescue Exception => e
   		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	token = Token.where(:token => params[:token]).first
	
	if token.nil? || token.expired <= Time.now
		return render :json => Settings.getError(4).to_json, :status => Settings.getError(4)["status"]
  	end

	show = Show.find_by_id(params[:show_id])
	
	if show.nil?
		return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
	end

	user = User.find_by_id(Token.joins(:user).select("users.id"))

	if !show.channel_id.present?
		subscription = Subscription.where(:user_id => user, :show => show).first
		if subscription.nil?
			return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
		end
		subscription.destroy
		return render :json => ["status":"true"].to_json
	else

		channel = Channel.find_by_id(show.channel_id)
		subscription = Subscription.where(:user_id => user, :channel => channel, :show => show).first

		if subscription.nil?
			return render :json => Settings.getError(3).to_json, :status => Settings.getError(3)["status"]
		end
		subscription.destroy

	  	return render :json => ["status":"true"].to_json
	end
  end

  private
  def channel_params
  	params.fetch(:channel_id)
  end

  private
  def show_params
  	params.fetch(:show_id)
  end
end
