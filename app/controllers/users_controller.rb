class UsersController < ApplicationController
	def new
	end

	def show
	end

	def create
		user = User.new(user_params)
		if user.save
			redirect_to "/sessions/new"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/users/new"
		end
	end
	def edit
	end
	def update
		user = current_user
		user.assign_attributes(update_params)
		if user.save
			redirect_to "/users/#{current_user.id}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/users/#{current_user.id}/edit"
		end
	end
	def destroy
		current_user.destroy
		session[:user_id] = nil
		redirect_to "/users/new"
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def update_params
			params.require(:user).permit(:name, :email)
		end
end
