class EmailIsNotNecessary < ActiveRecord::Migration
  def change
    remove_index :users, :email
    add_index :users, :username, :unique => true
  end
end
