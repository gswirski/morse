require 'spec_helper'

describe Paste do
  it "has valid factory" do
    FactoryGirl.create(:paste).should be_valid
  end

  it "validates code presence" do
    paste = FactoryGirl.build(:paste, code: nil)
    paste.should_not be_valid

  end

  describe ".save" do
    it "clears highlight cache" do
      paste = Paste.create(
        {
          code: "code",
          syntax: "cpp",
          highlighted_cache: "highlighted code"
        },
        without_protection: true
      )
      paste.read_attribute(:highlighted_cache).should == "highlighted code"
      paste.code = "new code"
      paste.save
      paste.read_attribute(:highlighted_cache).should be_nil
    end

    it "sets correct month" do
      paste = FactoryGirl.create(:paste)
      time = Time.now
      paste.month.should == "%04d-%02d" % [time.year, time.month]
    end
  end

  describe ".filename" do
    it "returns name if present" do
      paste = FactoryGirl.create(:paste)
      paste.filename.should == paste.name
    end

    it "returns slug if name not present" do
      paste = FactoryGirl.create(:paste, name: nil, slug: "a", syntax: "b")
      paste.filename.should == "a.b"
    end
  end

  describe ".highlighted" do
    it "highlights code exactly once" do
      Highlighter.any_instance.expects(:run).
        at_most(1).
        with("code", syntax: "cpp").
        returns("highlighted code")

      paste = Paste.create(code: "code", syntax: "cpp")

      3.times do
        paste.highlighted.should == "highlighted code"
      end
    end
  end

  describe ".by_user" do
    it "returns pastes that belong to user" do
      user = FactoryGirl.create(:user)
      owned = user.pastes.create(code: "aaa")
      anonymous = Paste.create(code: "bbb")
      pastes = Paste.by_user(user)
      pastes.should include(owned)
      pastes.should_not include(anonymous)
    end
  end

  describe ".count_by_month" do
    FactoryGirl.create(:paste, created_at: Time.utc(2012, 2, 1))
    FactoryGirl.create(:paste, created_at: Time.utc(2012, 2, 1))
    FactoryGirl.create(:paste, created_at: Time.utc(2012, 3, 1))
    FactoryGirl.create(:paste, created_at: Time.utc(2012, 4, 1))

    result = ActiveSupport::OrderedHash.new
    result["2012-04"] = 1
    result["2012-03"] = 1
    result["2012-02"] = 2
    count = Paste.count_by_month
    count[:total].should == 4
    count[:months].should == result
  end

  describe "managable_by?" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should be managable by author" do
      paste = FactoryGirl.build(:paste)
      paste.user_id = @user.id
      paste.save

      paste.managable_by?(@user).should be_true
    end

    it "shouldn't be managable by anyone else" do
      paste = FactoryGirl.build(:paste)
      paste.user_id = @user.id + 1
      paste.save
      paste.managable_by?(@user).should be_false
      paste.managable_by?(nil).should be_false

      paste = FactoryGirl.create(:paste)
      paste.managable_by?(@user).should be_false
      paste.managable_by?(nil).should be_false
    end

  end
end
