class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth[:info][:name].presence || auth[:info][:nickname].presence || auth[:extra][:raw_info][:login]
      end
    end
  end

end
