class Paste < ActiveRecord::Base
  belongs_to :user

  before_create :generate_slug
  before_save :negotiate_attributes

  default_scope order("created_at DESC")
  scope :by_user, lambda { |user| where("user_id = ?", user.id) }
  scope :list, lambda { select([:id, :slug, :name, :syntax, :created_at]) }

  def to_param
    slug
  end

  def filename
    read_attribute(:name).presence || "#{slug}.#{syntax}"
  end

  def highlighted
    if ! highlighted_at || highlighted_at < updated_at
      colorize
      save
    end
    read_attribute(:highlighted)
  end

  def file=(file)
    self.code = file.tempfile.read
  end

  def self.syntax_options
    [
      ['Plain text', 'txt'],
      ['C++', 'cpp'],
      ['Ruby', 'rb'],
      ['Python', 'py'],
      ['PHP', 'php']
    ]
  end

  protected

  def generate_slug
    o =  [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
    self.slug = (0..20).map{ o[rand(o.length)] }.join
  end

  def ext_from_name
    File.extname(self.name)[1..-1] if self.name.present?
  end

  def negotiate_attributes
    self.syntax = self.syntax.presence || ext_from_name || "txt"
  end

  def colorize
    lexer = self.syntax || "txt"
    lexer = "text" if lexer == "txt"
    source = self.code

    command = Pygmentize.bin
    command += " -Oencoding=utf-8"
    command += " -l #{lexer}"
    command += " -f html"

    self.highlighted = IO.popen(command, source ? "r+" : "r") do |io|
      if source
        io.puts source
        io.close_write
      end

      io.read
    end

    if $?.exitstatus != 0
      self.syntax = "txt"
      colorize
    end

    self.highlighted_at = Time.now
  end
end
