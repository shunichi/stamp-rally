FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "testuser#{n}" }
    provider 'remotty'
    sequence(:uid) {|n| n.to_s}
    token 'token'
    icon_url 'http://example.com/uploads/user/images/12345/testuser.jpg'
    auth_hash { OmniAuth::AuthHash.new({
      'provider' => 'remotty',
      'uid' => uid,
      'info' => {
         'name' => name,
         'email' => "#{name}@example.com",
         'icon_url' => "https://example.com/uploads/user/images/#{uid}/mock.jpg",
         'participation_id' => uid.to_i,
         'room_id' => 5,
      },
      'credentials' => {
         'token' => 'f845fe85d39f68ed7e58a84fc959c9304b184c7f669634ffa6b59ac07c6d128e"',
         'expires' => false
      },
      'extra' => {}
      }) }
    factory :master do
      name 'master1' # .env.test の MASTER_NAMES に含まれる
    end
  end
end
