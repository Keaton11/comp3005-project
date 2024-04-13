class FitnessClassesController < ApplicationController
  before_action :set_fitness_class, only: %i[ show edit update update_times destroy ]
  protect_from_forgery except: [:create, :update, :destroy], if: -> { request.format.json? }

  # GET /fitness_classes or /fitness_classes.json
  def index
    @fitness_classes = FitnessClass.all
  end

  # GET /fitness_classes/1 or /fitness_classes/1.json
  def show
  end

  # GET /fitness_classes/by_trainer/:trainer_id
  def by_trainer
    @fitness_classes = FitnessClass.where(trainer_id: params[:trainer_id])

    respond_to do |format|
      format.json { render json: @fitness_classes }
    end
  end

  # GET /fitness_classes/details/:fitness_class_id
  def details
    @fitness_class = FitnessClass.find(params[:fitness_class_id])

    @equipment = @fitness_class.fitness_class_equipments.joins(:equipment).select("equipment.*")
    @exercise_routines = @fitness_class.fitness_class_exercise_routines.joins(:exercise_routine).select("exercise_routines.*")

    member_count = @fitness_class.fitness_class_members.count

    response = {
      fitness_class: @fitness_class,
      equipment: @equipment,
      exercise_routines: @exercise_routines,
      member_count: member_count
    }

    render json: response
  end

  # GET /fitness_classes/new
  def new
    @fitness_class = FitnessClass.new
  end

  # GET /fitness_classes/group_sessions/:member_id
  def group_sessions
    member_id = params[:member_id]

    @fitness_classes = FitnessClass.where(group_session: true)
                                    .select('fitness_classes.*, 
                                            EXISTS (
                                              SELECT 1
                                              FROM fitness_class_members
                                              WHERE fitness_class_members.fitness_class_id = fitness_classes.id
                                                AND fitness_class_members.member_id = ' + member_id.to_s + '
                                            ) AS member_participates')
                                    .group('fitness_classes.id')

    render json: @fitness_classes
  end

  # GET /fitness_classes/all_group_sessions
  def all_group_sessions
    @fitness_classes = FitnessClass.where(group_session: true)
    render json: @fitness_classes
  end

  # GET /fitness_classes/1/edit
  def edit
  end

  # POST /fitness_classes or /fitness_classes.json
  def create
    @fitness_class = FitnessClass.new(fitness_class_params)

    respond_to do |format|
      if @fitness_class.save
        format.html { redirect_to fitness_class_url(@fitness_class), notice: "Fitness class was successfully created." }
        format.json { render :show, status: :created, location: @fitness_class }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fitness_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fitness_classes/1 or /fitness_classes/1.json
  def update
    respond_to do |format|
      if @fitness_class.update(fitness_class_params)
        format.html { redirect_to fitness_class_url(@fitness_class), notice: "Fitness class was successfully updated." }
        format.json { render :show, status: :ok, location: @fitness_class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fitness_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /fitness_classes/:id/update_times
  def update_times
    if @fitness_class.update(fitness_class_times_params)
      render json: { message: 'Fitness class was successfully updated.' }, status: :ok
    else
      render json: @fitness_class.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fitness_classes/1 or /fitness_classes/1.json
  def destroy
    fitness_class = FitnessClass.find(params[:id])
    fitness_class.transaction do
      fitness_class.destroy!
    end

    respond_to do |format|
      format.html { redirect_to fitness_classes_url, notice: "Fitness class was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def handle_empty_delete
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitness_class
      @fitness_class = FitnessClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fitness_class_params
      params.require(:fitness_class).permit(:room_id, :trainer_id, :group_session, :start_time, :end_time)
    end

    def fitness_class_times_params
      params.require(:fitness_class).permit(:start_time, :end_time)
    end
end
