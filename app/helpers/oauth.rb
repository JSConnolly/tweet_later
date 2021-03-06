helpers do
  def consumer
    OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://api.twitter.com")
  end

  def request_token 
    session[:request_token] ||= consumer.get_request_token(:oauth_callback => "http://localhost:9292/auth")
  end

  def get_access_token
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session[:token] = access_token.token
    session[:secret] = access_token.secret
    session.delete(:request_token)
  end

  def client
    # return session[:client] if session[:client]
    @client = Twitter::Client.new(
          :oauth_token => session[:token],                 
          :oauth_token_secret => session[:secret])

    user = TwitterUser.find_or_create_by_twitter_id(@client.user.id)
    user.username = @client.user.screen_name
    user.access_token = session[:token]
    user.access_secret = session[:secret]
    user.save
    session[:twitter_user_id] = user.id

    @client
  end


end
