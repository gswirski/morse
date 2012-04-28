require 'spec_helper'

describe PastesController do
  describe "GET index" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
    end

    it "assigns pastes array" do
      Paste.expects(:by_user).with(@user).at_least_once.returns(Paste)
      get :index
      assigns.should include(:pastes)
    end

    it "assigns count array" do
      Paste.expects(:count_by_month)
      get :index
      assigns.should include(:count)
    end
  end

  describe "GET show" do
    it "assigns paste object" do
      Paste.expects(:find_by_slug).with('2').returns(:paste_object)
      get :show, id: "2"
      assigns.should include(:paste)
      assigns[:paste].should eq(:paste_object)
    end
  end

  describe "GET download" do
    it "sends paste file" do
      paste = FactoryGirl.create(:paste)
      controller.stubs(:render).times(0..1) # because of some Rails/RSpec bug
      controller.expects(:send_data).with(
        paste.code,
        all_of(has_key(:filename), has_key(:type))
      )
      get :download, id: paste.slug
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

  describe "GET edit" do
    before(:each) do
      @paste = FactoryGirl.create(:paste)
    end

    it "authorizes user" do
      controller.expects(:authorize!).with(:manage, @paste)
      get :edit, id: @paste.slug
    end

    it "sets paste" do
      get :edit, id: @paste.slug
      assigns.should include(:paste)
    end
  end

  describe "POST update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @paste = FactoryGirl.create(:paste, user_id: @user.id)
    end

    it "authorizes user" do
      controller.expects(:authorize!).with(:manage, @paste)
      post :update, id: @paste.slug, paste: {}
    end

    it "sets paste" do
      get :edit, id: @paste.slug
      assigns.should include(:paste)
    end

    it "updates attributes" do
      sign_in(@user)
      post :update, id: @paste.slug, paste: { name: "lorem.ipsum" }
      assigns[:paste].name.should == "lorem.ipsum"
    end
  end

  describe "DELETE destroy" do
    it "destroys paste when called by author" do
      user = FactoryGirl.create(:user)
      paste = FactoryGirl.build(:paste)
      paste.user_id = user.id
      paste.save

      lambda do
        sign_in(user)
        delete :destroy, id: paste.slug
      end.should change(Paste, :count).by(-1)
    end

    it "shouldn't delete paste when user not authorized" do
      user = FactoryGirl.create(:user)
      paste = FactoryGirl.build(:paste)
      paste.user_id = user.id + 1
      paste.save

      lambda do
        sign_in(user)
        delete :destroy, id: paste.slug
      end.should change(Paste, :count).by(0)

    end
  end
end
