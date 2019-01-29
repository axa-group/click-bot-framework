class CreateTrainingMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :training_messages do |t|
    	t.integer :off_topic_id
    	t.string :text

      t.timestamps
    end

    add_index :training_messages, :off_topic_id
  end
end
