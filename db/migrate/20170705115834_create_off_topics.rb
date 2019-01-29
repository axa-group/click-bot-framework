class CreateOffTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :off_topics do |t|
    	t.string :name
    	t.string :response

      t.timestamps
    end
  end
end
