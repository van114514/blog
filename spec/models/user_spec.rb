require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
    name: "Example User",
    email: "user@example.com",
    password: "foobar",
    password_confirmation: "foobar")
  end 

  describe "User" do
    it "is valid" do
      expect(@user).to be_valid
    end
  end

  describe "name" do
    it "gives presence" do
      @user.name = "   "
      expect(@user).to be_invalid
    end

    context "51 characters" do
      it "is too long" do
        @user.name = 'a'*51
        expect(@user).to be_invalid
      end
    end
  end

  describe "email" do
    it "gives presence" do
      @user.email = "   "
      expect(@user).to be_invalid
    end

    context "256 characters" do
      it "is too long" do
        @user.email = 'a'*244 + "@example.com"
        expect(@user).to be_invalid
      end
    end

    it "rejects invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_addresses
        expect(@user).to be_invalid
      end
    end

    it "accepts valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it "is unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to be_invalid
    end

    it "is saved as lower-case" do
      @user.email = "Foo@ExAMPle.CoM"
      @user.save!
      expect(@user.reload.email).to eq 'foo@example.com'
    end

  end

  describe "password and password_confirmation" do
    it "are present (nonblank)" do
      @user.password = @user.password_confirmation = " "*6
      expect(@user).to be_invalid
    end

    it "gives a minimum length" do
      @user.password = @user.password_confirmation = "a"*5
      expect(@user).to be_invalid
    end
  end

  describe "authenticated?" do
    context "remember_digest is nil" do
      it "return false" do
        expect(@user.authenticated?('')).to eq false
      end
    end
  end
end
