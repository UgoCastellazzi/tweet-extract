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

    Alert.all.each do |alert|
      puts "start for #{alert.keyword}"
      client.search("#{alert.keyword}", result_type: "recent").take(3).collect do |tweet|
        if Tweet.exists?(content: tweet.text)
          next
        else
          if tweet.user.followers_count > alert.follower_threshold
            Tweet.create!(
              date: tweet.created_at,
              twitter_account: tweet.user.name,
              handdle: tweet.user.screen_name,
              content: tweet.text,
              retweets_count: tweet.retweet_count,
              comments_count: 0,
              likes_count: tweet.favorite_count,
              alert_id: alert.id
            )
          end
        end
      end
    end
  end
end
