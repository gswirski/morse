class Paste < ActiveRecord::Base
  SYNTAXES = [['Plain text', 'text'], ['C++', 'cpp'], ['Ruby', 'rb'],
      ['Python', 'py'], ['PHP', 'php']]

  belongs_to :user

  default_scope order("created_at DESC")
  scope :by_user, lambda { |user| where(:user_id => user.id) }
  scope :list, lambda { select([:id, :slug, :name, :syntax, :created_at]) }

  attr_accessible :code, :name, :syntax

  validates :code, presence: true

  before_create :generate_slug
  before_save :clear_highlighted_cache

  def highlighted
    read_attribute(:highlighted_cache).presence || colorize
  end

  def filename
    read_attribute(:name).presence || "#{slug}.#{syntax}"
  end

  def to_param
    slug
  end

  private

  def colorize
    options = {}
    options[:syntax] = syntax if syntax
    options[:filename] = name if name

    output, syntax = Highlighter.run(code, options)
    update_attributes(
      { highlighted_cache: output, syntax: syntax },
      without_protection: true
    )

    output
  end

  def generate_slug
    unless slug.present?
      o =  [('a'..'z'),('0'..'9')].map {|i| i.to_a}.flatten
      self.slug = (0..30).map { o[rand(o.length)] }.join
    end
  end

  def clear_highlighted_cache
    unless changed.include?("highlighted_cache")
      self.highlighted_cache = nil
    end
  end
end
