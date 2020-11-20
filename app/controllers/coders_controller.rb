class CodersController < ApplicationController
  before_action :set_coder, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @query = params[:query]

      @coders = policy_scope(Coder.global_search(@query))
    else
      @coders = policy_scope(Coder.all)
    end
    @coders = @coders.tagged_with(params[:tag]) if params[:tag].present?
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

  def edit
    authorize @coder
  end

  def update
    @coder.update(coder_params)
    authorize @coder
    redirect_to coder_path(@coder)
  end

def tagged
  if params[:tag].present?
    @coders = policy_scope(Coders.tagged_with(params[:tag]))
  else
  render :index
  end
end

  private

  def coder_params
    params.require(:coder).permit(:name, :price_per_day, :email, :phone_number, :description, :photo, tag_list: [])
  end

  def set_coder
    @coder = Coder.find(params[:id])
    authorize @coder
  end
end
