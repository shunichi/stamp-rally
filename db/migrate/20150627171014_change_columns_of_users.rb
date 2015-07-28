class ChangeColumnsOfUsers < ActiveRecord::Migration
  def up
    change_column :users, :name, :string, null: false
    change_column :users, :provider, :string, null: false
    change_column :users, :uid, :string, null: false
    change_column :users, :token, :string, null: false
  end

  def down
    change_column :users, :name, :string, null: true
    change_column :users, :provider, :string, null: true
    change_column :users, :uid, :string, null: true
    change_column :users, :token, :string, null: true
  end
end
