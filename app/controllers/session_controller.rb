class SessionController < ApplicationController
  def new
  end
	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = ["Invalid email/password combination"]
			redirect_to :back
		end
	end
	def delete
		reset_session
		redirect_to '/session/new'
	end
end
