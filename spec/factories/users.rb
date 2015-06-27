FactoryGirl.define do
  factory :user do
    name 'testuser'
    provider 'remotty'
    uid '12345'
    token 'token'
    icon_url 'http://example.com/uploads/user/images/12345/testuser.jpg'
    auth_hash OmniAuth::AuthHash.new({'uid' => '12345'})

    factory :master do
      name 'master1' # .env.test の MASTER_NAMES に含まれる
    end
  end
end
