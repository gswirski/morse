class Highlighter
  attr_accessor :source, :lexer

  def initialize(source, lexer)
    @source = source
    @lexer = lexer
  end

  def colorize
    command = Pygmentize.bin
    command += " -Oencoding=utf-8"
    command += " -l #{@lexer}"
    command += " -f html"

    highlighted = IO.popen(command, @source ? "r+" : "r") do |io|
      if @source
        io.puts @source
        io.close_write
      end

      io.read
    end

    if $?.exitstatus != 0
      @syntax = "txt"
      colorize
    else
      highlighted
    end
  end
end
