class AddHighlightedToPastes < ActiveRecord::Migration
  def change
    add_column :pastes, :highlighted, :text
  end
end
