class ExerciseRoutinesController < ApplicationController
  before_action :set_exercise_routine, only: %i[ show edit update destroy ]

  # GET /exercise_routines or /exercise_routines.json
  def index
    @exercise_routines = ExerciseRoutine.all
  end

  # GET /exercise_routines/1 or /exercise_routines/1.json
  def show
  end

  # GET /exercise_routines/new
  def new
    @exercise_routine = ExerciseRoutine.new
  end

  # GET /exercise_routines/1/edit
  def edit
  end

  # POST /exercise_routines or /exercise_routines.json
  def create
    @exercise_routine = ExerciseRoutine.new(exercise_routine_params)

    respond_to do |format|
      if @exercise_routine.save
        format.html { redirect_to exercise_routine_url(@exercise_routine), notice: "Exercise routine was successfully created." }
        format.json { render :show, status: :created, location: @exercise_routine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercise_routines/1 or /exercise_routines/1.json
  def update
    respond_to do |format|
      if @exercise_routine.update(exercise_routine_params)
        format.html { redirect_to exercise_routine_url(@exercise_routine), notice: "Exercise routine was successfully updated." }
        format.json { render :show, status: :ok, location: @exercise_routine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_routines/1 or /exercise_routines/1.json
  def destroy
    @exercise_routine.destroy!

    respond_to do |format|
      format.html { redirect_to exercise_routines_url, notice: "Exercise routine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_routine
      @exercise_routine = ExerciseRoutine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_routine_params
      params.require(:exercise_routine).permit(:exercise_id, :repetitions, :weight, :time, :distance)
    end
end
