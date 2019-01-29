class AddLanguageCodeToOffTopics < ActiveRecord::Migration[5.1]
  def change
  	add_column :off_topics, :language_code, :string, default: "en"
  end
end
