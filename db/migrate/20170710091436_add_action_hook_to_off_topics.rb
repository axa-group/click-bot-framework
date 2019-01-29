class AddActionHookToOffTopics < ActiveRecord::Migration[5.1]
  def change
  	add_column :off_topics, :action_hook, :string
  end
end
