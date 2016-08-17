class LikesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]
	def create 
		Like.create(secret:Secret.find(params[:id]), user: User.find(session[:user_id]))
		redirect_to :back
	end

	# def destroy
	# 	Like.where(secret: Secret.find(params[:id]), user: User.find(session[:user_id])).destroy_all
	# 	redirect_to :back
	# end

	def destroy
		like = Like.where(secret: Secret.find(params[:id]), user: User.find(session[:user_id]))
		like.destroy_all if User.find(session[:user_id]) == current_user
		redirect_to :back
	end

end
