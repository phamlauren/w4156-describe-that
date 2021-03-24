# ./app/controllers/auth0_controller.rb
class Auth0Controller < ApplicationController
  def callback
    # OmniAuth stores the informatin returned from Auth0 and the IdP in request.env['omniauth.auth'].
    # In this code, you will pull the raw_info supplied from the id_token and assign it to the session.
    # Refer to https://github.com/auth0/omniauth-auth0#authentication-hash for complete information on 'omniauth.auth' contents.
    auth_info = request.env['omniauth.auth']
    session[:userinfo] = auth_info['extra']['raw_info']

    # If a User does not exist with auth0Id = session[:userinfo]['sub'], then it is the user's first time logging in
    # So create aUser for them and now we can attach description_track, video_request, and video_request_upvote to them via
    # user = User.find_by(auth_id: session[:userinfo]['sub'])
    if !User.exists?(auth_id: session[:userinfo]['sub'])
      User.create!(auth_id: session[:userinfo]['sub'], username: session[:userinfo]['nickname'])

    # Redirect to the URL you want after successful auth
    redirect_to '/'
  end

  def failure
    # Handles failed authentication -- Show a failure page (you can also handle with a redirect)
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  private
  # AUTH0_CONFIG = Rails.application.config_for(:auth0)

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: ENV['AUTH0_CLIENT_ID']
    }

    URI::HTTPS.build(host: ENV['AUTH0_DOMAIN'], path: '/v2/logout', query: to_query(request_params)).to_s
  end

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{CGI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end

end
