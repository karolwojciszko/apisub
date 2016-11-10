class Tvguide < ApplicationRecord
	def self.get_tv_guide_app_url()
		return "https://apitv.herokuapp.com"
	end

	def self.guidetv_get(start)
		require 'net/http'
		
		url = URI.parse(Tvguide.get_tv_guide_app_url()+'/tvguide/get?start='+start)
		req = Net::HTTP::Get.new(url.to_s)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme == "https")
		response = http.request(req)

		return response.body
	end
end
