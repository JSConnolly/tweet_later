class TwitterUser < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy

  def tweet(status)
    tweet = Tweet.create(content: status, twitter_user_id: self.id)
    TweetWorker.perform_async(self.id, status) #changed to pass in id instead of status
  end
end
