class AddHighlightedAtToPastes < ActiveRecord::Migration
  def change
    add_column :pastes, :highlighted_at, :datetime
  end
end
