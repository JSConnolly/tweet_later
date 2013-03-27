class TweetWorker
  include Sidekiq::Worker


  def client(twitter_user_id)
    twitter_user = TwitterUser.find(twitter_user_id)
    @client = Twitter::Client.new(
      :oauth_token => twitter_user.access_token,                 
      :oauth_token_secret => twitter_user.access_secret )
  end

  def perform(twitter_user_id, status)
    puts status
    puts "*"*500
    user  = TwitterUser.find(twitter_user_id)
    # tweet = user.tweets.find_by_content(status).content

    client(twitter_user_id).update(status)


    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end
end
