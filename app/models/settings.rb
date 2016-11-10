class Settings
	def self.getError(id)
		errors =  {
			1 => {
				"status" => 500,
				"message" => "Unexpected error",
				"label" => "UNEXPECTED_ERROR"},
			2 => {
				"status" => 200,
				"message" => "Missing parameters. Check documentation",
				"label" => "MISSING_PARAMS"},
			3 => {
				"status" => 200,
				"message" => "Value of your params is incorrect",
				"label" => "WRONG_PARAMS"},	
			4 => {
				"status" => 401,
				"message" => "You are not authorized to call this action",
				"label" => "ACCESS_DENIED"},
			5 => {
				"status" => 200,
				"message" => "This show/channel already is in your subscription",
				"label" => "ALREADY_EXISTS"},
		}

		if errors[id].nil?
			id = 1
		end
		return errors[id]
	end

	def self.getTokenValidationTime()
		#2h
		return 60*60*2
	end



end