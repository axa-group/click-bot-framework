class CreatePlatforms < ActiveRecord::Migration[5.1]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :verify_token
      t.string :access_token
      t.text :decision_tree
      t.timestamps
    end
  end
end
