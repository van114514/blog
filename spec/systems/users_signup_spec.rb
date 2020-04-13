require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do

  it "is invalid because it has no name" do
    visit signup_path
    fill_in 'user_name', with: ''
    fill_in 'user_email', with: 'user@invalid'
    fill_in 'user_password', with: 'foo'
    fill_in 'user_password_confirmation', with: 'bar'
    click_on 'Create my account'
    expect(current_path).to eq signup_path
    expect(page).to have_selector '#error_explanation'
  end

  it "is valid because it fulfils condition of input" do
    visit signup_path
    fill_in 'user_name', with: 'Example User'
    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Create my account'
    expect(current_path).to eq user_path(1)
    expect(page).not_to have_selector '#error_explanation'
    expect(page).to have_selector('.alert-success', text: 'Welcome to the Sample App!')
  end

end