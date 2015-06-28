class Stamp < ActiveRecord::Base
  belongs_to :trainee, class_name: 'User'
  belongs_to :master, class_name: 'User'

  validates :trainee_id, uniqueness: { scope: :master_id }
  validates :trainee_id, :master_id, presence: true

  validate :ensure_trainee
  validate :ensure_master

  private
  def ensure_trainee
    errors.add(:trainee, '半人前でないとスタンプをもらえません') unless trainee.trainee?
  end

  def ensure_master
    errors.add(:master, '一人前でないとスタンプを押せません') unless master.master?
  end
end
