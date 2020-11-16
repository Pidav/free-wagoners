class CodersController < ApplicationController

  def index
    @coders = Coder.all
  end

  def show
    @coder = Coder.find(params[:id])
  end

  def new
    @coder = Coder.new
  end

  def create
    @coder = Coder.new(coder_params)
    if @coder.save
      redirect_to coder_path(@coder)
    else
      render 'new'
    end
  end

  def update
    @coder = Coder.find(params[:id])
    @coder = Coder.update(coder_params)
  end

  def edit
    @coder = Coder.find(params[:id])
  end

  private

  def coder_params
    params.require(:coder).permit(:name, :price_per_day, :email, :phone_number, :description)
  end
end
