class SecretsController < ApplicationController
	def index
		@secrets = Secret.all
	end
	def create
		secret = Secret.new(content:params[:content], user: current_user)
		if secret.save
			redirect_to "/users/#{current_user.id}"
		else
			flash[:errors] = secret.errors.full_messages
			redirect_to "/users/#{current_user.id}"
		end
	end
	def destroy
		secret = Secret.find_by(id: params[:id], user_id: current_user.id)
		if secret
			secret.destroy
			redirect_to "/users/#{current_user.id}"
		else
			redirect_to "/sessions/new"
		end
	end
end
