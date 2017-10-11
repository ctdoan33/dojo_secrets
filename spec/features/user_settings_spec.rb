require 'rails_helper'
feature "User Settings Dashboard" do
	before do
		@user = create(:user)
		log_in
		visit "/users/#{@user.id}/edit"
	end
	scenario "visit users edit page" do
		expect(page).to have_field("user[name]")
		expect(page).to have_field("user[email]")
	end
	scenario "inputs filled out correctly" do
		expect(page).to have_field("user[name]", with: @user.name)
		expect(page).to have_field("user[email]", with: @user.email)
	end
	scenario "incorrectly updates information" do
		fill_in "user[name]", with: ""
		fill_in "user[email]", with: ""
		click_button("Update")
		expect(current_path).to eq("/users/#{@user.id}/edit")
		expect(page).to have_text("Name can't be blank")
		expect(page).to have_text("Email is invalid")
	end
	scenario "correctly updates information" do
		fill_in "user[name]", with: "updated name"
		fill_in "user[email]", with: "updated@email.com"
		click_button("Update")
		expect(current_path).to eq("/users/#{@user.id}")
		expect(page).to have_text("updated name")
	end
	scenario "destroys user and redirects to registration page" do
		click_button("Delete Account")
		expect(current_path).to eq("/users/new")
	end
end
