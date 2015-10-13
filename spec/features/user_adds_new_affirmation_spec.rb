require 'rails_helper'

feature "User adds new affirmation" do
  background do
    sign_in
    click_link "Add an affirmation"
  end

  scenario "User inputs a valid affirmation" do
    fill_in "Affirmation text", with: "I'm the best!"
    click_button "Submit"
    expect(page).to have_content("Your affirmation has been added!")
    expect(page).to have_content("I'm the best!")
  end

  scenario "User inputs an invalid affirmation" do
    fill_in "Affirmation text", with: ""
    click_button "Submit"
    expect(page).to have_content("Please fix the errors below.")
    expect(page).to have_content("Text can't be blank")
  end
end