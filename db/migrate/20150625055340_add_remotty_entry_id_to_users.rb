class AddRemottyEntryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remotty_entry_id, :integer
  end
end
