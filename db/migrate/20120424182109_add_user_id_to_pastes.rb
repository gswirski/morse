class AddUserIdToPastes < ActiveRecord::Migration
  def change
    add_column :pastes, :user_id, :integer
    add_index :pastes, :user_id

  end
end
