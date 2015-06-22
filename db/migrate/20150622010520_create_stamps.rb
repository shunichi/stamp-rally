class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.integer :user_id, null: false
      t.integer :master_id, null: false

      t.timestamps null: false
    end
    add_index :stamps, [:user_id, :master_id], unique: true
  end
end
