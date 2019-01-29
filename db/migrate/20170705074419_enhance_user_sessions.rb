class EnhanceUserSessions < ActiveRecord::Migration[5.1]
  def up
  	add_column :user_sessions, :node_id, :integer
    UserSession.all.each do |us|
    	us.update_attributes(node_id: JSON.parse(us.data)['node_id'].to_i) rescue nil
    end
    remove_column :user_sessions, :data
  end
end
