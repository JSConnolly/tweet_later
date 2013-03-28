class TweetWorker
  include Sidekiq::Worker

  def client(twitter_user_id)
    twitter_user = TwitterUser.find(twitter_user_id)
    @client = Twitter::Client.new(
      :oauth_token => twitter_user.access_token,                 
      :oauth_token_secret => twitter_user.access_secret )
  end

  def perform(twitter_user_id, status)
    begin
      user = TwitterUser.find(twitter_user_id)
      client(twitter_user_id).update(status)  
    rescue Twitter::Error => e
        # >PROPAGATE SOMEWHERE IF ERROR      
    end

    # raise "fuck you" <--- FORCING ERRORS
    
  end

  def retries_exhausted(*args)
    
  end

end


  # begin
  #   client.account.sms.messages.create(
  #     :from => ENV['TWILIO_PHONE'],
  #     :to => params[:phone],
  #     :body => params[:say]
  #   )
  #   prank.succeeded = true
  # rescue Twilio::REST::RequestError => e
  #   prank.succeeded = false
  #   prank.error_messages = "#{e.class}: #{e.to_s}"
  # end
