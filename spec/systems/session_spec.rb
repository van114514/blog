require 'rails_helper'

RSpec.describe "Sessions", type: :system do

  describe "Login" do
    let(:user) { create(:user) }
    context "with invalid information" do
      it "deletes flash messages when users input invalid information then other links" do
        visit login_path
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'Log in'
        expect(current_path).to eq login_path
        expect(page).to have_selector '.alert-danger'
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end

    context "with valid information" do
      it "contains account button without login button" do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(current_path).to eq user_path(1)
        expect(page).to have_link 'Account'
        click_on 'Account'
        expect(page).to have_link 'Log out', href: logout_path
        expect(page).to have_link 'Profile', href: user_path(user)
        expect(page).not_to have_link 'Log in', href: login_path
      end
    end
  end

  describe "Logout" do 
    let(:user) { create(:user) }
    it "contains login button without accout button" do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(current_path).to eq user_path(1)
      expect(page).to have_link 'Account'
      click_on 'Account'
      click_on 'Log out'
      expect(current_path).to eq root_path
      expect(page).to have_link 'Log in', href: login_path
      expect(page).not_to have_link 'Account'
    end
  end
end