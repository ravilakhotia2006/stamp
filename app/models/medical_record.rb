class MedicalRecord < ApplicationRecord

	belongs_to :user
	has_many :prescriptions
end
