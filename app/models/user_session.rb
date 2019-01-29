class UserSession < ApplicationRecord
	belongs_to :platform
	belongs_to :off_topic, optional: true

	def undo_last_decision
    DecisionTree.new(platform.decision_tree_xml).get_parent_node_id(node_id)
	end
end
