class Paste < ActiveRecord::Base
  belongs_to :user

  before_create :generate_slug, :colorize

  def to_param
    slug
  end

  def file=(file)
    self.code = file.tempfile.read
  end

  def self.syntax_options
    [
      ['', '-'], ['Plain text', 'text'], ['C++', 'cpp'],
      ['Ruby', 'rb'], ['Python', 'py'], ['PHP', 'php']
    ]
  end

  protected
  
  def generate_slug
    o =  [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
    self.slug = (0..20).map{ o[rand(o.length)] }.join
  end
  
  def colorize
    lexer = self.syntax || "-"
    source = self.code

    command = Morse::Application.config.pygmentize_command || 'pygmentize'
    command += " -Oencoding=utf-8"
    command += (lexer == '-') ? " -g" : " -l #{lexer}"
    command += " -f html"

    self.highlighted = IO.popen(command, source ? "r+" : "r") do |io|
      if source
        io.puts source
        io.close_write
      end

      io.read
    end
  end
end
