class AlertsController < ApplicationController

  def index
    @alerts = Alert.all
  end

  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    @alert.save
    redirect_to alerts_path
  end

  def show
    @alert = Alert.find(params[:id])
  end

  def edit
    @alert = Alert.find(params[:id])
  end

  def update
    @alert = Alert.find(params[:id])
    @alert.update(alert_params)
    redirect_to alert_path(@alert)
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    redirect_to alerts_path
  end

  private

  def alert_params
    params.require(:alert).permit(:keyword, :region, :follower_threshold)
  end

end
