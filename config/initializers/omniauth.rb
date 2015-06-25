Rails.application.config.middleware.use OmniAuth::Builder do
  provider :remotty, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret,
           {client_options: {site: Rails.application.secrets.omniauth_site}}
end
