class ResourceMapping < ApplicationRecord
	has_one :resource_owner, class_name: 'User', foreign_key: 'user_id'
	has_one :accessing_user, class_name: 'User', foreign_key: 'user_id'
	has_many :medical_records
end
