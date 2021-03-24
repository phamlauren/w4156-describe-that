# ./config/initializers/auth0.rb
# AUTH0_CONFIG = Rails.application.config_for(:local_env)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV['auth0_client_id'],
    ENV['auth0_client_secret'],
    ENV['auth0_domain'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end