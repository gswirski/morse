require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    it "logins successfully" do
      user = User.create(username: "lorem", password: "ipsum", password_confirmation: "ipsum")

      post :create, :user => { username: "lorem", password: "ipsum" }
      cookies.signed[:user_id].should == user.id
    end
  end
  
  describe "DELETE destroy" do
    it "destroys cookie" do
      cookies.signed[:user_id] = 1
      delete :destroy
      cookies.signed[:user_id].should be_nil
      response.should redirect_to(root_path)
    end
  end
end
