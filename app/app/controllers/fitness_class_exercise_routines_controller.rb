class FitnessClassExerciseRoutinesController < ApplicationController
  before_action :set_fitness_class_exercise_routine, only: %i[ show edit update destroy ]
  protect_from_forgery except: [:create, :update, :destroy], if: -> { request.format.json? }

  # GET /fitness_class_exercise_routines or /fitness_class_exercise_routines.json
  def index
    @fitness_class_exercise_routines = FitnessClassExerciseRoutine.all
  end

  # GET /fitness_class_exercise_routines/1 or /fitness_class_exercise_routines/1.json
  def show
  end

  # GET /fitness_class_exercise_routines/new
  def new
    @fitness_class_exercise_routine = FitnessClassExerciseRoutine.new
  end

  # GET /fitness_class_exercise_routines/1/edit
  def edit
  end

  # POST /fitness_class_exercise_routines or /fitness_class_exercise_routines.json
  def create
    @fitness_class_exercise_routine = FitnessClassExerciseRoutine.new(fitness_class_exercise_routine_params)

    respond_to do |format|
      if @fitness_class_exercise_routine.save
        format.html { redirect_to fitness_class_exercise_routine_url(@fitness_class_exercise_routine), notice: "Fitness class exercise routine was successfully created." }
        format.json { render :show, status: :created, location: @fitness_class_exercise_routine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fitness_class_exercise_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fitness_class_exercise_routines/1 or /fitness_class_exercise_routines/1.json
  def update
    respond_to do |format|
      if @fitness_class_exercise_routine.update(fitness_class_exercise_routine_params)
        format.html { redirect_to fitness_class_exercise_routine_url(@fitness_class_exercise_routine), notice: "Fitness class exercise routine was successfully updated." }
        format.json { render :show, status: :ok, location: @fitness_class_exercise_routine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fitness_class_exercise_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fitness_class_exercise_routines/1 or /fitness_class_exercise_routines/1.json
  def destroy
    @fitness_class_exercise_routine.destroy!

    respond_to do |format|
      format.html { redirect_to fitness_class_exercise_routines_url, notice: "Fitness class exercise routine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitness_class_exercise_routine
      @fitness_class_exercise_routine = FitnessClassExerciseRoutine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fitness_class_exercise_routine_params
      params.require(:fitness_class_exercise_routine).permit(:fitness_class_id, :exercise_routine_id)
    end
end
