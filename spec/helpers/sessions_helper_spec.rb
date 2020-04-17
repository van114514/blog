require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe "#current_user" do
    let(:user) {create(:user)}

    context "session is nil" do
      it "returns right" do
        remember(user)
        expect(current_user).to eq user
        expect(is_logged_in?).to eq true
      end
    end

    context "remember digest is wrong" do
      it "returns nil" do
        remember(user)
        user.update_attribute(:remember_digest,User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end
  end
end
