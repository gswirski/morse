require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets new user" do
      get :new
      assigns.should include(:user)
    end
  end

  describe "POST create" do
    it "builds user from params" do
      post :create, :user => { "username" => "lorem" }
      assigns.should include(:user)
      assigns[:user][:username].should eq("lorem")
    end

    it "persists valid user" do
      User.any_instance.stubs(:valid?).returns(true)
      post :create, :user => { "username" => "lorem" }
      user = assigns[:user]
      user.should be_persisted
      response.should redirect_to(root_path)
    end

    it "shouldn't persist invalid paste" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create, :user => { "username" => "lorem" }
      user = assigns[:user]
      user.should_not be_persisted
    end
  end
end
