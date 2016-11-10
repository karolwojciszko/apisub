class Tvguide < ApplicationRecord
	def self.get_tv_guide_app_url()
		return "https://apitv.herokuapp.com"
	end

	def self.guidetv_get(start)
		require 'net/http'
		
		url = URI.parse(Tvguide.get_tv_guide_app_url()+'/tvguide/get?start='+start)
		req = Net::HTTP::Get.new(url.to_s)
		http.use_ssl = true
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}

		return res.body
	end
end
