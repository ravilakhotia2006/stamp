class CreateMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :medical_records do |t|
			t.string :note
			t.integer :user_id, index: true

      # more fields needed to maintain medical_records
      t.timestamps
    end
  end
end
