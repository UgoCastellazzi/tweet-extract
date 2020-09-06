class AlertsController < ApplicationController
  
  def index
    @user = current_user
    @alerts = policy_scope(Alert).order(created_at: :desc)
  end

  def new
    @alert = Alert.new
    authorize @alert
  end

  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    authorize @alert
    @alert.save
    redirect_to alerts_path
  end

  def show
    @alert = Alert.find(params[:id])
    authorize @alert
  end

  def edit
    @alert = Alert.find(params[:id])
    authorize @alert
  end

  def update
    @alert = Alert.find(params[:id])
    @alert.update(alert_params)
    authorize @alert
    redirect_to alert_path(@alert)
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    authorize @alert
    redirect_to alerts_path
  end

  private

  def alert_params
    params.require(:alert).permit(:keyword, :exact_keyword, :keywords_excluded, 
    :hashtags, :mentionned_accounts, :answers_included, :answers_only,
    :retweets_included, :retweets_only, :begin_date, :end_date, :language, :follower_threshold)
  end

end
