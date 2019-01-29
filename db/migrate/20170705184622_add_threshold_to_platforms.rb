class AddThresholdToPlatforms < ActiveRecord::Migration[5.1]
  def change
  	add_column :platforms, :threshold, :float, default: 0.2
  end
end
