class Paste < ActiveRecord::Base
  SYNTAXES = [['Plain text', 'text'], ['C++', 'cpp'], ['Ruby', 'rb'],
      ['Python', 'py'], ['PHP', 'php']]

  validates :code, :presence => true

  before_save :clear_highlighted_cache

  def highlighted
    read_attribute(:highlighted_cache).presence || colorize
  end

  private

  def colorize
    options = {}
    options[:syntax] = syntax if syntax
    options[:filename] = name if name

    output, syntax = Highlighter.run(code, options)
    update_attributes(highlighted_cache: output, syntax: syntax)

    output
  end

  def clear_highlighted_cache
    unless changed.include?("highlighted_cache")
      self.highlighted_cache = nil
    end
  end
end
