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
end
