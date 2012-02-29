class Paste < ActiveRecord::Base
  SYNTAXES = [['Plain text', 'txt'], ['C++', 'cpp'], ['Ruby', 'rb'],
      ['Python', 'py'], ['PHP', 'php']]
end
