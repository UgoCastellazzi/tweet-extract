class LeadsController < ApplicationController
  skip_after_action :verify_authorized, only: [:update_tweets]

  def index
    @alert = Alert.find(params[:alert_id])
    @leads = policy_scope(Lead).order(created_at: :desc).where(alert_id: @alert.id)

    respond_to do |format|
      format.html
      format.csv { send_data @leads.to_csv }
    end
  end

  def destroy
    @lead = Lead.find(params[:id])
    @lead.destroy
    authorize @lead
    redirect_to alert_leads_path(@lead.alert)
  end

  def update_tweets
    @alert = Alert.find(params[:alert_id])
    FetchTweetsJob.perform_now(@alert)
    redirect_to alert_leads_path(@alert)
  end

end
