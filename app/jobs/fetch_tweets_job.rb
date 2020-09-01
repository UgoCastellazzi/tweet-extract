require 'twitter'

class FetchTweetsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_KEY_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    # Alert.all.each do |alert|
      client.search("to:justinbieber", result_type: "recent").take(1).collect do |tweet|
        puts "#{tweet.text}"
        puts "#{tweet.user.name}"
        puts "#{tweet.user.screen_name}"
        puts "#{tweet.user.followers_count}"
        puts "#{tweet.retweet_count}"
        puts "#{tweet.favorite_count}"
        puts "#{tweet.created_at}"
        # if Tweet.exists?(link: "https://twitter.com/i/web/status/#{tweet.id}")
        #   return
        # else
        #   if tweet.user.followers_count > 5000
        #     Tweet.create!(
        #       handdle: tweet.user.screen_name,
        #       content: tweet.text,
        #       date: tweet.created_at,
        #       link: "https://twitter.com/i/web/status/#{tweet.id}",
        #       keyword_id: keyword.id
        #     )
        #   end
        # end
      end
    # end
  end
end
