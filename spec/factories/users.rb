FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "testuser#{n}" }
    provider 'remotty'
    sequence :uid
    token 'token'
    icon_url 'http://example.com/uploads/user/images/12345/testuser.jpg'
    auth_hash { OmniAuth::AuthHash.new({'uid' => uid}) }

    factory :master do
      name 'master1' # .env.test の MASTER_NAMES に含まれる
    end
  end
end
