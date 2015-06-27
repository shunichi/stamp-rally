class Stamp < ActiveRecord::Base
  belongs_to :user
  belongs_to :master, class_name: 'User'

  validates :user_id, uniqueness: { scope: :master_id }
  validates :user_id, :master_id, presence: true

  def self.max_count
    User.master_names.size
  end
end
