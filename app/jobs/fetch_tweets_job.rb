require 'twitter'

class FetchTweetsJob < ApplicationJob
  queue_as :default

  def perform(alert)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_KEY_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    client.search("#{alert.compute_search}", result_type: "recent").take(10).collect do |tweet|
      if Lead.exists?(tweet_content: tweet.text)
        next
      else
        if alert.follower_threshold.nil? || tweet.user.followers_count > alert.follower_threshold
          Lead.create!(
            date: tweet.created_at,
            twitter_display_name: tweet.user.name,
            handdle: tweet.user.screen_name,
            tweet_content: tweet.text.gsub('/(?:,|^)([^",]+|"(?:[^"]|"")*")?/g',' ').gsub("\n", ' '),
            tweet_id: tweet.id,
            description: tweet.user.description.gsub('/(?:,|^)([^",]+|"(?:[^"]|"")*")?/g',' ').gsub("\n", ' '),
            followers: tweet.user.followers_count,
            following: tweet.user.friends_count,
            profile_pic_url: tweet.user.profile_image_url,
            alert_id: alert.id
          )
        end
      end
    end
  end
end
