require 'spec_helper'

describe User do
  it "checks if passwords are identical" do
    user = User.new(username: "test", password: "aaa", password_confirmation: "aaa")
    user.should be_valid
    user = User.new(username: "test", password: "aaa", password_confirmation: "bbb")
    user.should_not be_valid
  end
end
