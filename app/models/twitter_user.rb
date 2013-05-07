class TwitterUser < ActiveRecord::Base
  has_many :tweets
  has_many :recent_tweets, :class_name => 'Tweet', :limit => 10, :order => 'id DESC'
  after_create :fetch_tweets!

  def fetch_tweets!
    new_tweets = fetch_new_tweets!
    update_twitter_user_cache
    new_tweets
  end

  def fetch_new_tweets!
    tweets = Twitter.user_timeline(self.username, {count: 10})
    tweets.map do |tweet|
      Tweet.create(twitter_user: self, status: tweet.text, tweet_created_at: tweet.created_at)
    end
  end

  def update_twitter_user_cache
    self.update_attributes(cached_at: Time.now)
    self.update_attributes(stale_threshold: find_stale_threshold)
  end

  def find_stale_threshold
    tweet_times = self.tweets.each_cons(2).map {|a,b| a.tweet_created_at - b.tweet_created_at}
    (tweet_times.inject(:+))/(tweet_times.count.to_f)
  end

  def cache_stale?
    (Time.now - self.cached_at) > self.stale_threshold
  end
end
