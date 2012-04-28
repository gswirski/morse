require 'spec_helper'

describe ApplicationController do
  describe "authenticate_user!" do
    it "does nothing when user is authenticated" do
      ApplicationController.any_instance.stubs(:signed_in?).returns(true)
      lambda { controller.send(:authenticate_user!) }.should_not raise_error
    end

    it "raises an error when user is not authenticated" do
      ApplicationController.any_instance.stubs(:signed_in?).returns(false)
      lambda { controller.send(:authenticate_user!) }.should raise_error Security::UserNotAuthenticated
    end
  end

  describe "authenticate_from_token" do
    controller do
      def index; render nothing: true; end
    end

    it "tries to authenticate user" do
      User.expects(:find_for_token_authentication).with("token")
      get :index, auth_token: "token"
    end

    it "sets current_user if user found" do
      User.expects(:find_for_token_authentication).with("token").returns("user")
      get :index, auth_token: "token"
      assigns[:current_user].should == "user"
    end

    it "does nothing when user not found" do
      User.expects(:find_for_token_authentication).with("token").returns(nil)
      get :index, auth_token: "token"
      assigns[:current_user].should be_nil
    end
  end

  describe "authorize!" do
    class Resource
      def destroyable_by?(user)
        user
      end
    end

    it "raises exception when not authorized" do
      ApplicationController.any_instance.stubs(:signed_in?).returns(true)
      ApplicationController.any_instance.stubs(:current_user).returns(false)
      lambda { controller.send(:authorize!, [:destroy, Resource.new]) }.should
        raise_error Security::UserNotAuthenticated
    end

    it "does not raise exception when authorized" do
      ApplicationController.any_instance.stubs(:signed_in?).returns(true)
      ApplicationController.any_instance.stubs(:current_user).returns(true)
      lambda { controller.send(:authorize!, [:destroy, Resource.new]) }.should_not
        raise_error Security::UserNotAuthenticated

    end

  end
end
