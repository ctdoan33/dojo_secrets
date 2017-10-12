require 'rails_helper'
RSpec.describe SecretsController, type: :controller do
  before do
    @user = create(:user)
    @secret = create(:secret, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
	it "cannot access index" do
		get :index
		expect(response).to redirect_to("/sessions/new")
	end
    it "cannot access create" do
		post :create
		expect(response).to redirect_to("/sessions/new")
	end
    it "cannot access destroy" do
		delete :destroy, id: @secret.id
		expect(response).to redirect_to("/sessions/new")
	end
  end
end