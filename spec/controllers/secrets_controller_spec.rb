require 'rails_helper'

RSpec.describe SecretsController, type: :controller do
	before do
		@user = create_user
		@secret = Secret.create(content: "secret", user: @user)
	end
	describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to('/session/new')
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to('/session/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @secret
      expect(response).to redirect_to('/session/new')
    end
  end

  describe "when logged in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
      @secret = @user.secrets.create(content: 'Ooops')
    end
    it "cannot access destroy" do
      delete :destroy, id: @secret, user_id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end

end
