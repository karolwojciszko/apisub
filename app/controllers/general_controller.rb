class GeneralController < ApplicationController
  def error
   error2 = Settings.getError(params[:id].to_i)
   puts(error2)
   return render :json => error2.to_json, :status => error2["status"]
  end
end
