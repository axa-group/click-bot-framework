class AddLanguageCodeToPlatforms < ActiveRecord::Migration[5.1]
  def change
  	add_column :platforms, :language_code, :string, default: "en"
  end
end
