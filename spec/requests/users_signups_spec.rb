require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "POST /signup" do
    context "with invalid signup information" do
      it "fail" do
        get signup_path
        expect{
          post signup_path, params: {
            user:{
              name: "",
              email:"user@invalid",
              password: "foo",
              password_confirmation: "bar"
            }
          }
        }.not_to change(User, :count)
        expect(is_logged_in?).to eq false
      end
    end

    context "with valid signup information" do
      it "success" do
        get signup_path
        expect {
          post signup_path, params: {
            user: {
              name: "Example User",
              email: "user@example.com",
              password: "password",
              password_confirmation: "password"
            }
          }
        }.to change(User, :count).by(1)
        expect(is_logged_in?).to eq true
      end
    end
  end
end
