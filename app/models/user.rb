class User < ActiveRecord::Base
  has_many :stamps, foreign_key: 'trainee_id', dependent: :destroy
  # 与えたスタンプという意味のいい言葉が思いつかない(given_stamps だともらったスタンプっぽい気がした)
  has_many :sent_stamps, class_name: 'Stamp', foreign_key: 'master_id', dependent: :destroy

  validates :name, :provider, :uid, :auth_hash, :user_type, :token, :icon_url, presence: true

  enum user_type: [ :trainee, :master ]
  serialize :auth_hash, JSON

  scope :doing_rally, -> { where.not(rally_started_at: nil) }

  before_create :set_user_type
  def set_user_type
    self.user_type = 'master' if self.class.master_names.member?(name)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.auth_hash = auth
      user.token = auth[:credentials][:token]
      user.icon_url = URI::join( ENV['OMNIAUTH_SITE'], auth[:info][:icon_url] || '/noImage.jpg')
      if auth[:info]
        user.name = auth[:info][:name].presence || auth[:info][:nickname].presence || auth[:extra][:raw_info][:login]
      end
    end
  end

  def self.master_names
    ENV['MASTER_NAMES'].split(',').map(&:strip)
  end

  def self.master_count
    master_names.size
  end

  def stamped_by?(master)
    stamps.find_by(master: master).present?
  end

  def stamp_completed?
    stamps.count == User.master_count
  end

  def start_rally!
    unless rally_started?
      self.rally_started_at = Time.current
      save!
      post_rally_start_to_remotty
    end
  end

  def rally_started?
    rally_started_at.present?
  end

  def post_rally_start_to_remotty
    message = I18n.t('remotty.messages.rally_started', name: name, url: Rails.application.routes.url_helpers.user_url(self))
    response = remotty_client.post_entry(message)
    update(remotty_entry_id: response['entry']['id'])
  end

  def post_stamp_completion_to_remotty
    message = I18n.t('remotty.messages.stamp_completed')
    remotty_client.post_entry(message, remotty_entry_id)
  end

  def post_stamp_creation_to_remotty(stamp)
    message = I18n.t('remotty.messages.stamp_created', name: name, stamp_count: stamp.trainee.stamps.count, stamp_max: User.master_count)
    remotty_client.post_entry(message, stamp.trainee.remotty_entry_id)
    stamp.trainee.post_stamp_completion_to_remotty if stamp.trainee.stamp_completed?
  end

  def post_stamp_destruction_to_remotty(stamp)
    message = I18n.t('remotty.messages.stamp_destroyed', name: name, stamp_count: stamp.trainee.stamps.count, stamp_max: User.master_count)
    remotty_client.post_entry(message, stamp.trainee.remotty_entry_id)
  end

  private
  def remotty_client
    @remotty_client ||= Remotty::Group.new(self.token, id: ENV['REMOTTY_GROUP_ID'])
  end
end
