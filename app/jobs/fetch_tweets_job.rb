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
    client.search('"' + "#{alert.keyword}" + '"' + "-rt -RT" + "@adam__alg", result_type: "recent").take(10).collect do |tweet|
      if Lead.exists?(tweet_content: tweet.text)
        next
      else
        if tweet.user.followers_count > alert.follower_threshold
          Lead.create!(
            date: tweet.created_at,
            twitter_display_name: tweet.user.name,
            handdle: tweet.user.screen_name,
            tweet_content: tweet.text,
            tweet_id: tweet.id,
            description: tweet.user.description,
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

# match large
# match exact
# mot exclu
# ce hashtag
# langue
# mentionnant ces comptes
# inclure / ne prendre que les réponses
# inclure / ne prendre que les RT
# dates