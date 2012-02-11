class Paste < ActiveRecord::Base
  belongs_to :user

  before_create :generate_slug
  before_save :negotiate_attributes

  default_scope order("created_at DESC")
  scope :by_user, lambda { |user| where("user_id = ?", user.id) }
  scope :list, lambda { select([:id, :slug, :name, :syntax, :created_at]) }

  SYNTAXES = [['Plain text', 'txt'], ['C++', 'cpp'], ['Ruby', 'rb'],
      ['Python', 'py'], ['PHP', 'php']]

  def file=(file)
    self.code = file.tempfile.read
  end

  def filename
    read_attribute(:name).presence || "#{slug}.#{syntax}"
  end

  def highlighted
    read_attribute(:highlighted) || colorize
  end

  def to_param
    slug
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

    processor = Highlighter.new(source, lexer)
    update_attribute(:highlighted, processor.colorize)

    read_attribute(:highlighted)
  end
end
