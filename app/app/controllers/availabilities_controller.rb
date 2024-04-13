class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: %i[ show edit update destroy ]
  protect_from_forgery except: [:create, :update, :destroy], if: -> { request.format.json? }

  # GET /availabilities or /availabilities.json
  def index
    @availabilities = Availability.where(trainer_id: current_user.roleable_id)
    respond_to do |format|
      format.html
      format.json { render json: @availabilities }
    end
  end

  # GET /availabilities/1 or /availabilities/1.json
  def show
  end

  # GET /availabilities/all
  def all
    @availabilities = Availability.all
    respond_to do |format|
      format.json { render json: @availabilities }
    end
  end

  # GET /availabilities/new
  def new
    @availability = Availability.new
  end

  # GET /availabilities/1/edit
  def edit
  end

  # POST /availabilities or /availabilities.json
  def create
    @availability = Availability.new(availability_params)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to availability_url(@availability), notice: "Availability was successfully created." }
        format.json { render :show, status: :created, location: @availability }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /availabilities/1 or /availabilities/1.json
  def update
    respond_to do |format|
      if @availability.update(availability_params)
        format.html { redirect_to availability_url(@availability), notice: "Availability was successfully updated." }
        format.json { render :show, status: :ok, location: @availability }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /availabilities/1 or /availabilities/1.json
  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy!
    respond_to do |format|
      format.html { redirect_to availabilities_url, notice: "Availability was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def handle_empty_delete
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.require(:availability).permit(:start_time, :end_time, :trainer_id)
    end
end
