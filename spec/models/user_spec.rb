require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is invalid with duplicated username" do
    FactoryGirl.create(:user)
    FactoryGirl.build(:user).should_not be_valid
  end

  it "checks if passwords are identical" do
    FactoryGirl.build(:user, password_confirmation: "lorem").should_not be_valid
  end

  it "ensures authentication token" do
    user = FactoryGirl.create(:user)
    user.authentication_token.should be_present
  end

  describe "reset_authentication_token" do
    it "resets token" do
      user = FactoryGirl.create(:user)
      old_token = user.authentication_token
      user.reset_authentication_token
      new_token = user.authentication_token
      new_token.should_not == old_token
    end
  end
end
