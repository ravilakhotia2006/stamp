class CreateResourceMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_mappings do |t|
			t.integer :medical_record_ids, array: true
			t.integer :accessing_user_id, index: true
			t.integer :resource_owner_id, index: true
      t.integer :status

      t.timestamps
    end
  end
end
