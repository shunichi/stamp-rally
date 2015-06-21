class User < ActiveRecord::Base

  serialize :auth_hash, JSON

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.auth_hash = auth
      if auth['info']
        user.name = auth[:info][:name].presence || auth[:info][:nickname].presence || auth[:extra][:raw_info][:login]
      end
    end
  end

end
