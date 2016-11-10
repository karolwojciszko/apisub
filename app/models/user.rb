class User < ApplicationRecord
	has_many :token
	has_many :subscription
end
