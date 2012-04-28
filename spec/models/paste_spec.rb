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
end
