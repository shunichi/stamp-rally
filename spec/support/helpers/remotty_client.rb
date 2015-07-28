module RemottyClientMockHelper
  def make_remotty_client_mock(user)
    remotty_client_mock = double('remotty client')
    allow(remotty_client_mock).to receive(:post_entry).and_return({'entry' => {'id' => 1234}})
    allow(user).to receive(:remotty_client).and_return(remotty_client_mock)
  end

  def make_remotty_client_mock_for_any_user
    remotty_client_mock = double('remotty client')
    allow(remotty_client_mock).to receive(:post_entry).and_return({'entry' => {'id' => 1234}})
    allow_any_instance_of(User).to receive(:remotty_client).and_return(remotty_client_mock)
  end
end

RSpec.configure do |config|
  config.include RemottyClientMockHelper
end
