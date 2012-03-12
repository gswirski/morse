require 'spec_helper'

describe Highlighter do
  before(:each) do
    @highlighter = Highlighter.new
    @code = "class TestClass; end"
  end

  describe ".guess_syntax" do
    it "handles exisiting filetypes" do
      [["test.txt", "text"], ["test.rb", "rb"], ["test.feature", "Cucumber"]].each do |type|
        @highlighter.guess_syntax(type[0]).should == type[1]
      end
    end
    
    it "fallbacks to plain text" do
      @highlighter.guess_syntax("test.not_existing").should == "text"
    end
  end

  describe ".colorize" do
    it "handles ruby code" do
      html = <<-END.squish
        <div class="highlight"><pre><span class="k">class</span>
        <span class="nc">TestClass</span><span class="p">;</span>
        <span class="k">end</span>
        </pre></div>
      END

      result = @highlighter.colorize(@code, "ruby").squish
      result.should == html
    end

    it "should render plain text" do
      html = <<-END.squish
        <div class="highlight"><pre>class TestClass; end
        </pre></div>
      END
      result = @highlighter.colorize(@code, "text").squish
      result.should == html
    end
  end

  describe ".run" do
    it "handles no metadata" do
      @highlighter.expects(:colorize).with(@code, "text").returns(@code)
      @highlighter.run(@code).should == [@code, "text"]
    end

    it "handles only filename" do
      @highlighter.expects(:colorize).with(@code, "rb").returns(@code)
      @highlighter.run(@code, filename: "test.rb").should == [@code, "rb"]

      @highlighter.expects(:colorize).with(@code, "cpp").returns(@code)
      @highlighter.run(@code, filename: "test.cpp").should == [@code, "cpp"]
    end

    it "handles only syntax" do
      @highlighter.expects(:colorize).with(@code, "rb").returns(@code)
      @highlighter.run(@code, syntax: "rb").should == [@code, "rb"]

      @highlighter.expects(:colorize).with(@code, "cpp").returns(@code)
      @highlighter.run(@code, syntax: "cpp").should == [@code, "cpp"]
    end

    it "handles both parameters" do
      @highlighter.expects(:colorize).with(@code, "rb").returns(@code)
      @highlighter.run(@code, filename: "test.cpp", syntax: "rb").should == [@code, "rb"]

      @highlighter.expects(:colorize).with(@code, "cpp").returns(@code)
      @highlighter.run(@code, filename: "test.feature", syntax: "cpp").should == [@code, "cpp"]
    end
  end
end
