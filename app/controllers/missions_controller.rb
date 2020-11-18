class MissionsController < ApplicationController
  def index
    @missions = Mission.all
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
    @mission.duration = @mission.end_date - @mission.start_date
    @mission.total_price = @mission.duration * @coder.price_per_day
    authorize @coder
    if @mission.save
      redirect_to dashboard_path(current_user)
    else
      render 'new'
    end
  end


  def update
    @mission = Mission.find(params[:id])
    @mission = Mission.update(coder_params)
  end

  # def show
  #   @missions = Mission.find(params[:id])
  # end

  private

  def coder_params
    params.require(:mission).permit(:start_date, :end_date, :total_price, :validated_mission, :title, :description)
  end
end
