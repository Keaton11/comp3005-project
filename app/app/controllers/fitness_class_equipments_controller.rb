class FitnessClassEquipmentsController < ApplicationController
  before_action :set_fitness_class_equipment, only: %i[ show edit update destroy ]
  protect_from_forgery except: [:create, :update, :destroy], if: -> { request.format.json? }

  # GET /fitness_class_equipments or /fitness_class_equipments.json
  def index
    @fitness_class_equipments = FitnessClassEquipment.all
  end

  # GET /fitness_class_equipments/1 or /fitness_class_equipments/1.json
  def show
  end

  # GET /fitness_class_equipments/new
  def new
    @fitness_class_equipment = FitnessClassEquipment.new
  end

  # GET /fitness_class_equipments/1/edit
  def edit
  end

  # POST /fitness_class_equipments or /fitness_class_equipments.json
  def create
    @fitness_class_equipment = FitnessClassEquipment.new(fitness_class_equipment_params)

    respond_to do |format|
      if @fitness_class_equipment.save
        format.html { redirect_to fitness_class_equipment_url(@fitness_class_equipment), notice: "Fitness class equipment was successfully created." }
        format.json { render :show, status: :created, location: @fitness_class_equipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fitness_class_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fitness_class_equipments/1 or /fitness_class_equipments/1.json
  def update
    respond_to do |format|
      if @fitness_class_equipment.update(fitness_class_equipment_params)
        format.html { redirect_to fitness_class_equipment_url(@fitness_class_equipment), notice: "Fitness class equipment was successfully updated." }
        format.json { render :show, status: :ok, location: @fitness_class_equipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fitness_class_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fitness_class_equipments/1 or /fitness_class_equipments/1.json
  def destroy
    @fitness_class_equipment.destroy!

    respond_to do |format|
      format.html { redirect_to fitness_class_equipments_url, notice: "Fitness class equipment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitness_class_equipment
      @fitness_class_equipment = FitnessClassEquipment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fitness_class_equipment_params
      params.require(:fitness_class_equipment).permit(:fitness_class_id, :equipment_id)
    end
end
