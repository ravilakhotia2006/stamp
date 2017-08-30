class User < ApplicationRecord
	has_many :roles
	has_many :medical_records
	
end
