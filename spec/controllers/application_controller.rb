require 'spec_helper'

describe ApplicationController do
  describe "authenticate_user!" do
    it "does nothing when user is authenticated" do
      ApplicationController.any_instance.stubs(:signed_in?).returns(true)
      { authenticate_user! }.should_not raise_error
    end

    it "raises an error when user is not authenticated" do
      ApplicationController.any_instance.stubs(:signed_in?).returns(true)
      { authenticate_user! }.should raise_error Security::UserNotAuthenticated
    end
  end
end
