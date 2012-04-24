require 'spec_helper'

describe PastesController do
  describe "GET show" do
    it "assigns paste object" do
      Paste.expects(:find_by_slug).with('2').returns(:paste_object)
      get :show, :id => '2'
      assigns.should include(:paste)
      assigns[:paste].should eq(:paste_object)
    end
  end

  describe "GET new" do
    it "sets new paste" do
      get :new
      assigns.should include(:paste)
    end
  end

  describe "POST create" do
    it "builds paste from params" do
      post :create, :paste => { "code" => "value" }
      assigns.should include(:paste)
      assigns[:paste][:code].should eq("value")
    end

    it "persists valid paste" do
      Paste.any_instance.stubs(:valid?).returns(true)
      post :create, :paste => { "code" => "value" }
      paste = assigns[:paste]
      paste.should be_persisted
      response.should redirect_to(paste_path(paste))
    end

    it "shouldn't persist invalid paste" do
      Paste.any_instance.stubs(:valid?).returns(false)
      post :create, :paste => { "code" => "value" }
      paste = assigns[:paste]
      paste.should_not be_persisted
    end

    it "should belong to current user" do
      user = FactoryGirl.create(:user)
      sign_in(user)
      post :create, :paste => { "code" => "value" }
      paste = assigns[:paste]
      paste.user_id.should == user.id
    end
  end
end
