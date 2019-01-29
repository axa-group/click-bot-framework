module ExternalService
	module Api

    EXTERNAL_SERVICE_API_URL = "YOUR_EXTERNAL_SERVICE_API_URL"
    EXTERNAL_SERVICE_API_TOKEN_URL = "#{EXTERNAL_SERVICE_API_URL}/oauth/token"
  
  
    def self.perform_action_hook(node_id, session)

      # query external service provide
      response = query_external_service_api("#{EXTERNAL_SERVICE_API_URL}/v1/your/resources/of/interest")
      
      # send response to user
      Facebook::Api::send_message(session, response)
  
      session.destroy   # delete user session
    end

    private
  
    def self.query_external_service_api(url, params={})
    	token = get_oauth2_token
      r = token.get(url)
      return JSON.parse(r.body) if r.status == 200
    end
  
    def self.post_to_external_service_api(url, params={})
    	token = get_oauth2_token
      r = token.post(url, params: params)
      return JSON.parse(r.body) if r.status == 201   
    end
  
    def self.patch_to_external_service_api(url, params={})
      token = get_oauth2_token
      r = token.patch(url, params: params)
      return true if r.status == 204 
    end

    # OAuth2: Resource Owner Password Credentials Grant
    def self.get_oauth2_token
    	client = OAuth2::Client.new(Rails.application.secrets.external_service_api_client_id, Rails.application.secrets.external_service_api_client_secret, token_url: EXTERNAL_SERVICE_API_TOKEN_URL)
    	encrypted_credentials = "Basic " + Base64.encode64("#{Rails.application.secrets.external_service_api_client_id}:#{Rails.application.secrets.external_service_api_client_secret}")
      return client.client_credentials.get_token(headers: {'Authorization': encrypted_credentials })
    end
  end
end