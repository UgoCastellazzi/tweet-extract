class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  
  def home
    redirect_to alerts_path
  end
end
