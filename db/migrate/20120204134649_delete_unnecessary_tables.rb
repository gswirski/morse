class DeleteUnnecessaryTables < ActiveRecord::Migration
  def change
    drop_table :groups_pastes
    drop_table :user_groups
    drop_table :groups
  end
end
