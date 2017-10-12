class LikesController < ApplicationController
	def create
		Like.create(user: current_user, secret: Secret.find(params[:secret_id]))
		redirect_to "/secrets"
	end

	def destroy
		like = Like.find(params[:id])
		if like.user == current_user
			like.destroy
			redirect_to "/secrets"
		else
			redirect_to "/sessions/new"
		end
	end
end
