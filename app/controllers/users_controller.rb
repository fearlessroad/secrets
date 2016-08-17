class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :udpate, :destroy]
	
	def index
	end
	def show
		@user = User.find(params[:id])
		@secrets = Secret.where(user: @user)
	end
	def create

		@user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

		if @user.save 
			session[:user_id] = @user.id
			redirect_to "/users/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
	end
	def edit 
		@user = User.find(params[:id])
	end
	def update
		user = User.find(params[:id])
		if user.update(name:params[:name], email:params[:email], password: params[:password])
			redirect_to "/users/#{params[:id]}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to :back
		end
	end
	def destroy
		user = User.find(params[:id]).destroy
		reset_session
		redirect_to '/session/new'

	end

end