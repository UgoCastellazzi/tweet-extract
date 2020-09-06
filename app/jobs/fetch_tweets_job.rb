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
    puts compute_search(alert)
    client.search("#{compute_search(alert)}", result_type: "recent").take(10).collect do |tweet|
      if Lead.exists?(tweet_content: tweet.text)
        next
      else
        if alert.follower_threshold.nil? || tweet.user.followers_count > alert.follower_threshold
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

  def keyword_creation(alert)
    if alert.exact_keyword
      '"' + "#{alert.keyword}" + '"'
    else
      "#{alert.keyword}"
    end
  end

  def excluded_keywords_creation(alert)
    result = ""
    alert.array_from_keywords_excluded.each do | keyword |
      result += "-#{keyword.strip} "
    end
    result.strip
  end

  def hashtags_creation(alert)
    result = ""
    alert.array_from_hashtags.each do | hashtag |
      result += "#{hashtag.strip} "
    end
    result.strip
  end

  def retweets_creation(alert)
    if alert.retweets_included
      ""
    else
      "-rt -RT"
    end
  end

  def compute_search(alert)
    "#{keyword_creation(alert)} #{excluded_keywords_creation(alert)} #{hashtags_creation(alert)} #{retweets_creation(alert)}"
  end

end
