class Stamp < ActiveRecord::Base
  belongs_to :trainee, class_name: 'User'
  belongs_to :master, class_name: 'User'

  validates :trainee_id, uniqueness: { scope: :master_id }
  validates :trainee_id, :master_id, presence: true
end
