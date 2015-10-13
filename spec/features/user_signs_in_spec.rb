require 'rails_helper'

feature "User signs in and adds a new affirmation" do
  scenario "with valid inputs" do
    sign_in
    expect(page).to have_content("You've logged in!")
  end

  scenario "with invalid inputs" do
    user = Fabricate(:user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: "nothing"
    click_button 'Sign In'
    expect(page).to have_content("There is something wrong with your email or password.")
  end
end