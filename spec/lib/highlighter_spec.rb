require 'spec_helper'

describe Highlighter do
  before(:each) do
    @highlighter = Highlighter.new
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

  describe ".run" do
    it "should handle ruby code" do
      code = "class TestClass; end"
      html = <<-END.squish
        <div class="highlight"><pre><span class="k">class</span>
        <span class="nc">TestClass</span><span class="p">;</span>
        <span class="k">end</span>
        </pre></div>
      END

      result = @highlighter.run(code, syntax: "ruby").squish
      result.should == html
    end
  end

  it "should render plain text" do
    code = "class TestClass; end"
    html = <<-END.squish
      <div class="highlight"><pre>class TestClass; end
      </pre></div>
    END
    result = @highlighter.run(code, syntax: "text").squish
    result.should == html
  end
end
