class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
    def new
        # render login page
    end
    def create
        user = User.find_by_email(params[:Email]).try(:authenticate, params[:Password])
        if user
            session[:user_id] = user.id
            redirect_to "/users/#{current_user.id}"
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