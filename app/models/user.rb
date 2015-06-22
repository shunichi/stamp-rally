class User < ActiveRecord::Base
  has_many :stamps, dependent: :destroy
  # 与えたスタンプという意味のいい言葉が思いつかない(given_stamps だともらったスタンプっぽい気がした)
  has_many :sent_stamps, class_name: 'Stamp', foreign_key: 'master_id', dependent: :destroy

  enum user_type: [ :student, :master, :admin ]
  serialize :auth_hash, JSON

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.auth_hash = auth
      if auth[:info]
        user.name = auth[:info][:name].presence || auth[:info][:nickname].presence || auth[:extra][:raw_info][:login]
      end
    end
  end

end
