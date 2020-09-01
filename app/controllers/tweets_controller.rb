class TweetsController < ApplicationController

  def index
    @alert = Alert.find(params[:alert_id])
    @tweets = policy_scope(Tweet).order(created_at: :desc).where(alert_id: @alert.id)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to alert_tweets_path(@tweet.alert)
  end

end
