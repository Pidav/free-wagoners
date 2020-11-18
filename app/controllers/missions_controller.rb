class MissionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @missions = policy_scope(Mission.all)
  end

  def new
    @mission = Mission.new
    @coder = Coder.find(params[:coder_id])
    @mission.coder = @coder
    authorize @coder
  end

  def create
    @mission = Mission.new(coder_params)
    @coder = Coder.find(params[:coder_id])
    @mission.coder = @coder
    duration = @mission.end_date - @mission.start_date
    @mission.total_price = duration * @coder.price_per_day
    @mission.user = current_user
    @mission.validated_mission = true
    authorize @mission
    if @mission.save
      redirect_to "/missions_recruteur"
    else
      render 'new'
    end
  end

  private

  def coder_params
    params.require(:mission).permit(:start_date, :end_date, :total_price, :validated_mission, :title, :description)
  end
end
