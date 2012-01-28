class RenamePasteGroupsToGroupsPastes < ActiveRecord::Migration
  def change
    rename_table :paste_groups, :groups_pastes
  end
end
