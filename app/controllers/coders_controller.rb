class CodersController < ApplicationController
  before_action :set_coder, only: [:show, :edit, :update]

  def index
    @coders = Coder.all
  end

  def show
  end

  def new
    @coder = Coder.new
  end

  def create
    @coder = Coder.new(coder_params)
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
