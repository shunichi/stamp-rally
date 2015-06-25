class AddIconUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :icon_url, :string, null: false
  end
end
