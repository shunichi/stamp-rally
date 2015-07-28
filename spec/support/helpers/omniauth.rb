module Omniauth

  module Mock
    DEFAULT_AUTH_INFO = {
        name: 'mockuser',
        email: 'mockuser@example.com',
        icon_url: 'https://example.com/uploads/user/images/1/mock.jpg',
        participation_id: 12345,
        room_id: 5,
    }.freeze
    DEFAULT_AUTH_HASH = {
      provider: 'remotty',
      uid: '123545',
      info: DEFAULT_AUTH_INFO,
      credentials: {
          token: 'mock_token',
          expires: false
      },
      extra: {}
    }.freeze
    def auth_mock(user = nil)
      auth_hash = Mock::DEFAULT_AUTH_HASH
      if user
        auth_info = DEFAULT_AUTH_INFO.merge(name: user.name, email: "#{user.name}@eample.com", icon_url: user.icon_url)
        auth_hash = auth_hash.merge(uid: user.uid, info: auth_info)
      end
      OmniAuth.config.mock_auth[:remotty] = OmniAuth::AuthHash.new(auth_hash)
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in")
      auth_mock
      click_link "Sign in"
    end

    def signin_as(user)
      auth_mock(user)
      visit '/auth/remotty'
    end
  end

end
