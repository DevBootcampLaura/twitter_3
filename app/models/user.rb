class User < ActiveRecord::Base
  has_many :tweets
  # Remember to create a migration!
  # def twitter_client
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV['TWITTER_KEY']
  #     config.consumer_secret     = ENV['TWITTER_SECRET']
  #     config.access_token        = self.oauth_token
  #     config.access_token_secret = self.oauth_secret
  #   end
  # end

  def tweet(status)

    tweet = Tweet.create!(:status => status)
    self.tweets << tweet
    puts "IN USER TWEET method"
    TweetWorker.perform_async(tweet.id)
  end

end
