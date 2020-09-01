class TweetsController < ApplicationController

  def index
    @alert = Alert.find(params[:alert_id])
    @tweets = @alert.tweets
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to alert_tweets_path(@tweet.alert)
  end

end
