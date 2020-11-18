class CodersController < ApplicationController
  before_action :set_coder, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @query = params[:query]
      @coders = Coder.where("name iLike '%#{params[:query]}%'")
    else
    @coders = policy_scope(Coder.all)
    end
  end

  def show
  end

  def new
    @coder = Coder.new
    authorize @coder
  end

  def create
    @coder = Coder.new(coder_params)
    @user = User.find(params[:user_id])
    @coder.user = @user
    authorize @coder
    if @coder.save
      redirect_to coder_path(@coder)
    else
      render 'new'
    end
  end

  def update
    @coder = Coder.update(coder_params)
    redirect_to coder_path(@coder)
  end

  def edit
  end

  private

  def coder_params
    params.require(:coder).permit(:name, :price_per_day, :email, :phone_number, :description, :photo)
  end

  def set_coder
    @coder = Coder.find(params[:id])
    authorize @coder
  end
end
