class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
	def index
		@secrets = Secret.all
	end
	def create
		secret = Secret.new(content: params[:New_Secret], user: User.find(session[:user_id]))
		if secret.save
			redirect_to :back
		else
			flash[:errors] = secret.errors.full_messages
			redirect_to :back
		end
	end
	def destroy
		secret = Secret.find(params[:id])
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{session[:user_id]}"
	end
end
