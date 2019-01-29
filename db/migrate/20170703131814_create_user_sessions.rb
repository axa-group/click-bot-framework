class CreateUserSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_sessions do |t|
      t.string :facebook_user_id
      t.text :data

      t.timestamps
    end

    add_index :user_sessions, :facebook_user_id
  end
end
