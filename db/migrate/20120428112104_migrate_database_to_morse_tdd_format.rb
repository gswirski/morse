class MigrateDatabaseToMorseTddFormat < ActiveRecord::Migration
  def up
    add_column :pastes, :highlighted_cache, "text"
    add_column :pastes, :month, "string"
    add_column :users,  :password_digest, "string"

    Paste.update_all("highlighted_cache = highlighted")
    Paste.update_all("month = substr(to_char(created_at AT TIME ZONE 'CET', 'YYYY-MM-DD'),1,7)")
    User.update_all("password_digest = encrypted_password")
  end

  def down
    remove_column :pastes, :highlighted_cache
    remove_column :pastes, :month
    remove_column :users,  :password_digest
  end
end
    #Paste.all.each do |paste|
      #paste.update_attribute(:highlighted_cache, paste.highlighted)
      #paste.update_attribute(:month, paste.created_at.strftime("%Y-%m"))
    #end

    #User.all.each do |user|
      #user.update_attribute(:password_digest, user.encrypted_password)
    #end
