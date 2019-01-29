class ChangeDataTypeOfDecisionTreeXml < ActiveRecord::Migration[5.1]
  def change
  	change_column :platforms, :decision_tree_xml, :longtext
  end
end
