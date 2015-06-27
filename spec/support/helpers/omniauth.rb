module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:remotty] = OmniAuth::AuthHash.new({
        'provider' => 'remotty',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'email' => 'mockuser@example.com',
          'icon_url' => 'https://example.com/uploads/user/images/1/mock.jpg',
          'participation_id' => 12345,
          'room_id' => 5,
        },
        'credentials' => {
          'token' => 'mock_token',
          'expires' => false
        },
        'extra' => {}
      })
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in")
      auth_mock
      click_link "Sign in"
    end
  end

end
