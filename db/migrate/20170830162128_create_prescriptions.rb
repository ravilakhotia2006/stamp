class CreatePrescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :prescriptions do |t|
      t.string :url
      t.string :description
      t.integer :medical_record_id, index: true
      
      t.timestamps
    end
  end
end
