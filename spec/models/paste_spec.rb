require 'spec_helper'

describe Paste do
  describe ".save" do
    it "clears highlight cache" do
      paste = Paste.create(
        code: "code",
        syntax: "cpp",
        highlighted_cache: "highlighted code"
      )
      paste.read_attribute(:highlighted_cache).should == "highlighted code"
      paste.code = "new code"
      paste.save
      paste.read_attribute(:highlighted_cache).should be_nil
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
end
