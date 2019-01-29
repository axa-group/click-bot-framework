class DecisionTree
	include ActiveModel::Validations

  validate :only_one_root

	def initialize(xml)
		@xml_root = Nokogiri::XML(xml).root
	end

	def node_ids
		@xml_root.xpath(".//Subprocess").map{|e| e["id"]}
	end

	def target_ids
		@xml_root.xpath(".//Edge/mxCell[@target]").map{|e| e["target"]}
	end

	def root_node_ids
		[node_ids - target_ids].flatten
	end

	def root_node_id
		root_node_ids.first
	end

	def edges_originating_from(node_id)
		@xml_root.xpath(".//Edge/mxCell[@source='#{node_id}']")
	end

	def get_node_by_id(node_id)
		@xml_root.xpath(".//Subprocess[@id='#{node_id}']").first
	end

	def get_parent_node_id(node_id)
		@xml_root.xpath(".//Edge/mxCell[@target='#{node_id}']").first["source"] rescue nil
	end

	private
	def only_one_root
		if root_node_ids.count > 1
			errors.add(:decision_tree_xml, "is invalid, it contains more than 1 root node")
		end
	end
end