require 'linkedin'

class LinkedinController < ApplicationController


	def index
    
    client = LinkedIn::Client.new("6b2ftar5nu2y", "GcN62dGOwcRfvKaP")
    request_token = client.request_token(:oauth_callback => 
                                      "http://#{request.host_with_port}/linkedin/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url

  end


  def callback
    client = LinkedIn::Client.new("6b2ftar5nu2y", "GcN62dGOwcRfvKaP")
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end       
    
    @connection1 = client.connections.first
    @connections = client.connections
    @profile = client.profile(:fields => %w(positions))
    @last_position = @profile.positions.first
    @last_title = @last_position.title
    @last_company = @last_position.company.name
		@companies = @profile.positions.each.map{|t| t.company}
  end

end
