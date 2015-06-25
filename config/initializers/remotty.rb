Remotty.setup do |config|
  config.client_id = Rails.application.secrets.omniauth_provider_key
  config.client_secret = Rails.application.secrets.omniauth_provider_secret
  config.site = Rails.application.secrets.omniauth_site
end