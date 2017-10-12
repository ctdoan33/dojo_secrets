require 'rails_helper'
feature "secret features" do
	before do
		@user = create(:user)
		@user2 = create(:user, email: "second@user.com")
		@secret2 = create(:secret, user: @user2, content: "Second user's secret")
		log_in
	end
	feature "Users personal secret page" do
		scenario "shouldn't see other user's secrets" do
			expect(page).to_not have_text(@secret2.content)
		end
		scenario "create a new secret" do
			fill_in "content", with: "First user's secret"
			click_button("Create Secret")
			expect(current_path).to eq("/users/#{@user.id}")
			expect(page).to have_text("First user's secret")
		end
		scenario "destroy secret from profile page, redirects to user profile page" do
			secret = create(:secret, user: @user)
			visit "/users/#{@user.id}"
			click_button("Delete")
			expect(current_path).to eq("/users/#{@user.id}")
			expect(page).not_to have_text(secret.content)
		end
	end
	feature "Secret Dashboard" do
		before do 
			@secret = create(:secret, user: @user)
			visit "/secrets"
		end
		scenario "displays everyone's secrets" do
			expect(page).to have_text(@secret.content)
			expect(page).to have_text(@secret2.content)  
		end
		scenario "destroy secret from index page, redirects to user profile page" do
			click_button("Delete")
			expect(current_path).to eq("/users/#{@user.id}")
			expect(page).not_to have_text(@secret.content)
		end
	end
end