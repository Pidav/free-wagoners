class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_mission, only: [:new, :create]

  def index
    @reviews = policy_scope(Review.all)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.mission = @mission
    authorize @review
    if @review.save
      redirect_to coder_path(@mission.coder) # vers la show du nesting model
    else
      render :new
    end
  end

  # def edit
  # end

  # def update
  #   @review.update(review_params)
  #   redirect_to review_path(@review) # vers la show
  # end

  def destroy
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def set_mission
    @mission = Mission.find(params[:mission_id])
    authorize @mission
  end

end
