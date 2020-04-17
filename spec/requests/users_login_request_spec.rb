require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do

  describe "Login" do
    let(:user) {create(:user)}

    context "valid information" do
      it "can logout if remember_digest is not nil" do
        get login_path
        post login_path, params: {session:{
          email: user.email,
          password: user.password
        }}
        expect(is_logged_in?).to eq true
        delete logout_path
        expect(is_logged_in?).to eq false
        delete logout_path
      end

      it "with remembering" do
        log_in_as(user, remember_me: '1')
        expect(cookies[:remember_token].empty?).to eq false
      end

      it "without remembering" do
        log_in_as(user, remember_me: '1')
        delete logout_path
        log_in_as(user,remember_me: '0')
        expect(cookies[:remember_token].empty?). to eq true
      end
    end
  end
end
