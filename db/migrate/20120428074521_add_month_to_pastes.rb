class AddMonthToPastes < ActiveRecord::Migration
  def change
    add_column :pastes, :month, :string
  end
end
