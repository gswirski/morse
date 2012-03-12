class Highlighter

  def self.run(code, options = {})
    new.run(code, options)
  end

  def run(code, options = {})
    syntax = options[:syntax] || guess_syntax(options[:filename]) || "text"
    [colorize(code, syntax), syntax]
  end

  def colorize(code, syntax)
    command = [Pygmentize.bin, "-l #{syntax}", "-f html", "-Oencoding=utf-8"]
    execute(command, code)
  end

  def guess_syntax(filename)
    if filename
      command = [Pygmentize.bin, "-N #{filename}"]
      execute(command).strip
    end
  end

  private

  def execute(command, stdin = nil)
    command = command.join(" ")

    IO.popen(command, stdin ? "r+" : "r") do |io|
      if stdin
        io.puts stdin
        io.close_write
      end

      io.read
    end
  end
end
