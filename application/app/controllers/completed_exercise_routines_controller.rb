class CompletedExerciseRoutinesController < ApplicationController
  before_action :set_completed_exercise_routine, only: %i[ show edit update destroy ]

  # GET /completed_exercise_routines or /completed_exercise_routines.json
  def index
    @completed_exercise_routines = CompletedExerciseRoutine.all
  end

  # GET /completed_exercise_routines/1 or /completed_exercise_routines/1.json
  def show
  end

  # GET /completed_exercise_routines/new
  def new
    @completed_exercise_routine = CompletedExerciseRoutine.new
  end

  # GET /completed_exercise_routines/member_routines/:member_id
  def member_routines
    @completed_routines = CompletedExerciseRoutine.joins(exercise_routine: :exercise)
                                                  .where(completed_exercise_routines: {member_id: params[:member_id]})
                                                  .select(
                                                    "completed_exercise_routines.*, 
                                                     exercises.name as exercise_name,
                                                     exercise_routines.repetitions,
                                                     exercise_routines.weight,
                                                     exercise_routines.time,
                                                     exercise_routines.distance"
                                                  )

    render json: @completed_routines.map { |routine|
      routine.attributes.merge({
        exercise_name: routine.exercise_name,
        routine_details: {
          repetitions: routine.repetitions,
          weight: routine.weight,
          time: routine.time,
          distance: routine.distance
        }
      })
    }
  end

  # GET /completed_exercise_routines/1/edit
  def edit
  end

  # POST /completed_exercise_routines or /completed_exercise_routines.json
  def create
    @completed_exercise_routine = CompletedExerciseRoutine.new(completed_exercise_routine_params)

    respond_to do |format|
      if @completed_exercise_routine.save
        format.html { redirect_to completed_exercise_routine_url(@completed_exercise_routine), notice: "Completed exercise routine was successfully created." }
        format.json { render :show, status: :created, location: @completed_exercise_routine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @completed_exercise_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /completed_exercise_routines/1 or /completed_exercise_routines/1.json
  def update
    respond_to do |format|
      if @completed_exercise_routine.update(completed_exercise_routine_params)
        format.html { redirect_to completed_exercise_routine_url(@completed_exercise_routine), notice: "Completed exercise routine was successfully updated." }
        format.json { render :show, status: :ok, location: @completed_exercise_routine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @completed_exercise_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /completed_exercise_routines/1 or /completed_exercise_routines/1.json
  def destroy
    @completed_exercise_routine.destroy!

    respond_to do |format|
      format.html { redirect_to completed_exercise_routines_url, notice: "Completed exercise routine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_completed_exercise_routine
      @completed_exercise_routine = CompletedExerciseRoutine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def completed_exercise_routine_params
      params.require(:completed_exercise_routine).permit(:member_id, :exercise_routine_id, :date)
    end
end
