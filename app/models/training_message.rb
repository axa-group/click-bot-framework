class TrainingMessage < ApplicationRecord
	belongs_to :off_topic, optional: true
	validates :text, presence: true

	delegate :language_code, to: :off_topic
end
