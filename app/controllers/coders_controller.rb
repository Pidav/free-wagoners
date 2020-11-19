class CodersController < ApplicationController
  before_action :set_coder, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @query = params[:query]
      sql_query = " \
        coders.name @@ :query \
        OR coders.description @@ :query \
        OR missions.title @@ :query \
        OR missions.description @@ :query \
      "
      @coders = policy_scope(Coder.joins(:missions).where(sql_query, query: "%#{params[:query]}%"))
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

  def edit
    authorize @coder
  end

  def update
    @coder.update(coder_params)
    authorize @coder
    redirect_to coder_path(@coder)
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
