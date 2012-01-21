class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :user
      t.references :group

      t.boolean :is_accepted
      t.boolean :is_owner

      t.timestamps
    end
  end
end
