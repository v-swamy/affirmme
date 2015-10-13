require 'rails_helper'

feature "User registers" do

  background do
    visit root_path
    click_link "Learn more >>"
  end

  scenario "User has valid info" do
    user_fills_in_valid_info
    click_button "Register"
    expect(page).to have_content("Your account has been created!")
  end

  scenario "User has invalid info" do
    user_fills_in_invalid_info
    click_button "Register"
    expect(page).to have_content("Please fix the errors below.")
    expect(page).to have_content("Phone can't be blank")
  end
end

def user_fills_in_valid_info
  fill_in "Name", with: "John Smith"
  fill_in "user_email", with: "john@nowhere.com"
  fill_in "Phone", with: "216-245-1234"
  fill_in "user_password", with: "password"
end

def user_fills_in_invalid_info
  fill_in "Name", with: "John Smith"
  fill_in "user_email", with: "john@nowhere.com"
  fill_in "Phone", with: ""
  fill_in "user_password", with: "password"
end