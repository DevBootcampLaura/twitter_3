class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user
    # tweeter = Twitter::Client.new(oauth_token: user)
    puts "IN TWEETWORKER BEFORE TWITTER REST CLIENT"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
    puts "AFTER twitter rest"
    client.update(tweet.status)
  end

end
