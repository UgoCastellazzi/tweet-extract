class TweetsController < ApplicationController

  skip_after_action :verify_authorized, only: [:update_tweets]

  def index
    @alert = Alert.find(params[:alert_id])
    @tweets = policy_scope(Tweet).order(created_at: :desc).where(alert_id: @alert.id)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to alert_tweets_path(@tweet.alert)
  end

  def update_tweets
    @alert = Alert.find(params[:alert_id])
    FetchTweetsJob.perform_now(@alert)
    redirect_to alert_tweets_path(@alert)
  end

end
