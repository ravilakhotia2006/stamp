class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
			t.integer :user_id, index: true

      t.timestamps
    end
  end
end
