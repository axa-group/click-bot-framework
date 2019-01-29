class EnhancePlatforms < ActiveRecord::Migration[5.1]
  def change
  	rename_column :platforms, :decision_tree, :decision_tree_xml
  end
end
