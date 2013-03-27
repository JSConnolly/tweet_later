class TweetWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def client(twitter_user_id)
    twitter_user = TwitterUser.find(twitter_user_id)
    @client = Twitter::Client.new(
      :oauth_token => twitter_user.access_token,                 
      :oauth_token_secret => twitter_user.access_secret )
  end

  def perform(twitter_user_id, status)
    user  = TwitterUser.find(twitter_user_id)
    begin
    client(twitter_user_id).update(status)
    rescue Twitter::Error::Forbidden => e
      puts "FORBBIDEN: #{e}"
      puts "%" * 100
    end
  end

  def retries_exhausted(*args)
    
  end

end
