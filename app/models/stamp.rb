class Stamp < ActiveRecord::Base
  belongs_to :user
  belongs_to :master, class_name: 'User'

  validates :user_id, uniqueness: { scope: :master_id }
end
