class AddConfirmationToOffTopic < ActiveRecord::Migration[5.1]
  def change
  	add_column :off_topics, :confirmation, :string
  end
end
