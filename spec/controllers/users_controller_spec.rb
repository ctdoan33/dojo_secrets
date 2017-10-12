require 'rails_helper'
RSpec.describe UsersController, type: :controller do
	before do
		@user = create(:user)
	end
	context "when not logged in" do
		before do
			session[:user_id] = nil
		end
		it "cannot access show" do 
			get :show, id: @user.id
			expect(response).to redirect_to("/sessions/new")
		end
		it "cannot access edit" do
			get :edit, id: @user.id
			expect(response).to redirect_to("/sessions/new")
		end
		it "cannot access update" do
			patch :update, id: @user.id
			expect(response).to redirect_to("/sessions/new")
		end
		it "cannot access destroy" do
			delete :destroy, id: @user.id
			expect(response).to redirect_to("/sessions/new")
		end
	end
end