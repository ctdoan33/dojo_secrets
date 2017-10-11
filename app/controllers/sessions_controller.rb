class SessionsController < ApplicationController
    def new
        # render login page
    end
    def create
        user = User.find_by_email(params[:Email]).try(:authenticate, params[:Password])
        if user
            session[:user_id] = user.id
            redirect_to "/users/#{session[:user_id]}"
		else
            flash[:errors] = ["Invalid"]
			redirect_to "/sessions/new"
		end
    end
    def destroy
        session[:user_id] = nil
        redirect_to "/sessions/new"
    end
end