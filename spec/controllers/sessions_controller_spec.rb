describe SessionsController, :omniauth do

  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe "#create" do

    it "creates a user" do
      expect {get :create, provider: :remotty}.to change{ User.count }.by(1)
    end

    it "creates a session" do
      expect(session[:user_id]).to be_nil
      get :create, provider: :remotty
      expect(session[:user_id]).not_to be_nil
    end

    it "redirects to the home page" do
      get :create, provider: :remotty
      expect(response).to redirect_to root_url
    end

  end

  describe "#destroy" do

    before do
      get :create, provider: :remotty
    end

    it "resets the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end

  end

end
