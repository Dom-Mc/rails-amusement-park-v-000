class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  def index
    authorize Attraction
    @attractions = policy_scope(Attraction)
  end

  def new
    @attraction = Attraction.new
    authorize @attraction
  end

  def create
    @attraction = Attraction.new(attractions_params)
    authorize @attraction

    if @attraction.save
      redirect_to @attraction, notice: "Attraction was successfully created."
    else
      render :new
    end
  end

  def show
    authorize @attraction
    @ride = @attraction.rides.build
  end

  def edit
    authorize @attraction
  end

  def update
    authorize @attraction
    if @attraction.update(attractions_params)
      redirect_to @attraction, notice: "Attraction was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @attraction
    @attraction.destroy
    redirect_to attractions_path, notice: "Attraction was successfully deleted."
  end

  private

    def set_attraction
      @attraction = Attraction.find(params[:id])
    end

    def attractions_params
      params.require(:attraction).permit(:name,
                                         :min_height,
                                         :happiness_rating,
                                         :nausea_rating,
                                         :tickets)
    end

end
