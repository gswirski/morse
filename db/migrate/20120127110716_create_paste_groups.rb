class CreatePasteGroups < ActiveRecord::Migration
  def change
    create_table :paste_groups do |t|
      t.references :paste
      t.references :group
    end
  end
end
