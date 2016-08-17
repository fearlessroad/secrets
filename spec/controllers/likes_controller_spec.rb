require 'rails_helper'

RSpec.describe LikesController, type: :controller do
before do
		@user = create_user
		@secret = Secret.create(content: "secret", user: @user)
end
	describe "when not logged in" do
		before do
			session[:user_id] = nil
		end
		it 'cannot like stuff' do
      		post :create, id: @secret
      		expect(response).to redirect_to('/session/new')
		end
		it 'cannot UNlike stuff' do
      		delete :destroy, id: @secret
      		expect(response).to redirect_to('/session/new')
		end
	end

	describe "when signed in as the wrong user" do

		before do
	      @wrong_user = create_user 'julius', 'julius@lakers.com'
	      session[:user_id] = @wrong_user.id
	      @secret = @user.secrets.create(content: 'Ooops')
	      request.env["HTTP_REFERER"] = "where_i_came_from"
	    end
	    it "cannot access destroy" do
	      delete :destroy, id: @secret, user_id: @user
	      expect(response).to redirect_to "where_i_came_from"
	    end
	end

end
