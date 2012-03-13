class AddHighlightedToPaste < ActiveRecord::Migration
  def change
    add_column :pastes, :highlighted_cache, :text
  end
end
