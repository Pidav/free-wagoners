class CodersController < ApplicationController
  before_action :set_coder, only: [:show, :edit, :update]

  def index
    @coders = policy_scope(Coder.all)
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
  end

  def edit
  end

  private

  def coder_params
    params.require(:coder).permit(:name, :price_per_day, :email, :phone_number, :description)
  end

  def set_coder
    @coder = Coder.find(params[:id])
    authorize @coder
  end
end
