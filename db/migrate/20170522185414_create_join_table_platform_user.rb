class CreateJoinTablePlatformUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :platforms, :users do |t|
      t.index [:platform_id, :user_id]
      t.index [:user_id, :platform_id]
    end
  end
end
