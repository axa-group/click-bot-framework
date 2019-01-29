class AddPlatformIdToUserSessions < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_sessions, :platform_id, :integer
  	add_index :user_sessions, :platform_id
  end
end
