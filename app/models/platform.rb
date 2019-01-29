class Platform < ApplicationRecord
	has_and_belongs_to_many :users
	has_many :user_sessions

	attr_accessor :tree

	validates :name, presence: true, uniqueness: true
	validate :decision_tree_integrity, unless: Proc.new { |p| p.decision_tree_xml.blank? }

	def tree
		@tree || (@tree = DecisionTree.new(decision_tree_xml))
	end

	def tree=(val)
		@tree = val
	end

	def to_s
		name
	end

	private
	def decision_tree_integrity
		if (DecisionTree.new(decision_tree_xml)).invalid?
			errors.add(:decision_tree_xml, "is invalid")
		end
	end

end
