require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	before do
		@user = create_user
	end
	describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, id: @user
      expect(response).to redirect_to('/session/new')
    end
    it "cannot access edit" do
      get :edit, id: @user
      expect(response).to redirect_to('/session/new')
    end
    it "cannot access update" do
      patch :update, id: @user
      expect(response).to redirect_to('/session/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @user
      expect(response).to redirect_to('/session/new')
    end
  end

end
