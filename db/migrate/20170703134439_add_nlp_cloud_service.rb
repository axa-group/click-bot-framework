class AddNlpCloudService < ActiveRecord::Migration[5.1]
  def change
  	add_column :platforms, :nlp_cloud_service_enabled, :boolean, default: false
  	add_column :platforms, :api_ai_client_access_token, :string
  end
end
