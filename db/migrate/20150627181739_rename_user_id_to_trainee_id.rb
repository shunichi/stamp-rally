class RenameUserIdToTraineeId < ActiveRecord::Migration
  def change
    rename_column :stamps, :user_id, :trainee_id
  end
end
