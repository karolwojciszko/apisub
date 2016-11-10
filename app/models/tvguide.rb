class Tvguide < ApplicationRecord
	def self.get_tv_guide_app_url()
		return "http://localhost:3001"
	end

	def self.guidetv_get(start)
		require 'net/http'
		
		url = URI.parse(Tvguide.get_tv_guide_app_url()+'/tvguide/get?start='+start)
		req = Net::HTTP::Get.new(url.to_s)
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}

		return res.body
	end
end
