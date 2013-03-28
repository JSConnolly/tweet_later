class TwitterUser < ActiveRecord::Base
  has_many :tweets, :dependent => :destroy

  def tweet(status)
    tweet = Tweet.create(content: status, twitter_user_id: self.id)
    begin
      worker_status = TweetWorker.perform_async(self.id, status)  
    rescue Exception => e
      worker_status = e
    end
    worker_status
  end

  def tweet_in(time, status)
    
    tweet = Tweet.create(content: status, twitter_user_id: self.id)
#    begin
      puts "%" * 100
      puts time
      puts status
      puts "%" * 100
      worker_status = TweetWorker.perform_at(time.to_i.minutes.from_now, self.id, status)  
      puts worker_status
      puts "^" * 100
#    rescue Exception => e
#      puts "something is fucked" * 1000
#      worker_status = e
#    end
    worker_status
  end

end
