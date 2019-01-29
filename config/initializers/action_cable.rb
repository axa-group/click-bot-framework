if Rails.env.development?
  Rails.application.config.action_cable.allowed_request_origins =  ['http://localhost:3000', 'http://127.0.0.1:3000']
end