require 'rails_helper'
feature 'User features ' do
	feature "user sign-up" do
		before do
			visit "/users/new"
		end
		scenario 'visits sign-up page' do
			expect(page).to have_field("user[name]")
			expect(page).to have_field("user[email]")
			expect(page).to have_field("user[password]")
			expect(page).to have_field("user[password_confirmation]")
		end
		scenario "with improper inputs, redirects back to sign in and shows validations" do
			click_button("Join")
			expect(current_path).to eq("/users/new")
			expect(page).to have_text("Name can't be blank")
			expect(page).to have_text("Email is invalid")
			expect(page).to have_text("Password can't be blank")
		end
		scenario "with proper inputs, create user and redirects to login page" do
			fill_in "user[name]", with: "validuser"
			fill_in "user[email]", with: "valid@email.com"
			fill_in "user[password]", with: "validpassword"
			fill_in "user[password_confirmation]", with: "validpassword"
			click_button("Join")
			expect(current_path).to eq("/sessions/new")
		end
	end
	feature "user dashboard" do 
		scenario "displays user information" do
			@user = create(:user)
			log_in
			expect(page).to have_text(@user.name)
			expect(page).to have_link("Edit Profile")
		end
	end
end
