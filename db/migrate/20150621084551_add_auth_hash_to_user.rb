class AddAuthHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :auth_hash, :text, null: false
  end
end
