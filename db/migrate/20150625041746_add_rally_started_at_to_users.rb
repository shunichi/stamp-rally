class AddRallyStartedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rally_started_at, :datetime
  end
end
