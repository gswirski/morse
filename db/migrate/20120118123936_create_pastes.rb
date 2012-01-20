class CreatePastes < ActiveRecord::Migration
  def change
    create_table :pastes do |t|
      t.string :name
      t.string :slug
      t.string :syntax
      t.text :code

      t.references :user

      t.timestamps
    end
  end
end
