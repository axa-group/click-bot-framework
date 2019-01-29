class AddOffTopicIdToUserSessions < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_sessions, :off_topic_id, :integer
  end
end
