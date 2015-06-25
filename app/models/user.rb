class User < ActiveRecord::Base
  has_many :stamps, dependent: :destroy
  # 与えたスタンプという意味のいい言葉が思いつかない(given_stamps だともらったスタンプっぽい気がした)
  has_many :sent_stamps, class_name: 'Stamp', foreign_key: 'master_id', dependent: :destroy

  enum user_type: [ :trainee, :master ]
  serialize :auth_hash, JSON

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.auth_hash = auth
      if auth[:info]
        user.name = auth[:info][:name].presence || auth[:info][:nickname].presence || auth[:extra][:raw_info][:login]
      end
      user.master! if master_name?(user.name)
    end
  end

  def self.master_names
    ENV['MASTER_NAMES'].split(',').map(&:strip)
  end

  def self.master_name?(name)
    master_names.member?(name)
  end

  def stamp_by(master)
    stamps.find_by(master: master)
  end

  def start_rally
    unless rally_started?
      self.rally_started_at = Time.current
      save!
    end
  end

  def rally_started?
    rally_started_at.present?
  end
end
