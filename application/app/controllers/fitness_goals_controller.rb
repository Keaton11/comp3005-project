class FitnessGoalsController < ApplicationController
  before_action :set_fitness_goal, only: %i[ show edit update destroy ]

  # GET /fitness_goals or /fitness_goals.json
  def index
    @fitness_goals = Member.find(current_user.roleable_id).fitness_goals
  end

  # GET /fitness_goals/1 or /fitness_goals/1.json
  def show
  end

  # GET /fitness_goals/new
  def new
    @fitness_goal = FitnessGoal.new
  end

  # GET /fitness_goals/1/edit
  def edit
  end

  # POST /fitness_goals or /fitness_goals.json
  def create
    @fitness_goal = FitnessGoal.new(fitness_goal_params)

    respond_to do |format|
      if @fitness_goal.save
        format.html { redirect_to fitness_goal_url(@fitness_goal), notice: "Fitness goal was successfully created." }
        format.json { render :show, status: :created, location: @fitness_goal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fitness_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fitness_goals/1 or /fitness_goals/1.json
  def update
    respond_to do |format|
      if @fitness_goal.update(fitness_goal_params)
        format.html { redirect_to fitness_goal_url(@fitness_goal), notice: "Fitness goal was successfully updated." }
        format.json { render :show, status: :ok, location: @fitness_goal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fitness_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fitness_goals/1 or /fitness_goals/1.json
  def destroy
    @fitness_goal.destroy!

    respond_to do |format|
      format.html { redirect_to fitness_goals_url, notice: "Fitness goal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitness_goal
      @fitness_goal = FitnessGoal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fitness_goal_params
      params.require(:fitness_goal).permit(:member_id, :exercise_id, :repetitions, :weight, :time, :distance)
    end
end
