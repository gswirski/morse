class CreatePastes < ActiveRecord::Migration
  def change
    create_table :pastes do |t|
      t.string :name
      t.string :slug
      t.string :syntax
      t.text :code

      t.timestamps
    end
  end
end
