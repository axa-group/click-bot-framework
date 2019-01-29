class CreateCustomLoggers < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_loggers do |t|
      t.datetime :started_at
      t.datetime :completed_at
      t.string :namespace
      t.string :message
      t.text :error_messages
      t.integer :alert_level

      t.timestamps
    end
  end
end
