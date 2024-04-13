class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members or /members.json
  def index
    if params[:search].present?
      @members = Member.joins(:user).where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @members = Member.all.includes(:user)
    end
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  def dashboard
    @member = Member.find(current_user.roleable_id)
    @completed_routines = CompletedExerciseRoutine.joins(exercise_routine: :exercise)
                                                  .where(completed_exercise_routines: {member_id: @member.id})
                                                  .select(
                                                    "completed_exercise_routines.*, 
                                                     exercises.name as exercise_name,
                                                     exercise_routines.repetitions as repetitions,
                                                     exercise_routines.weight as weight,
                                                     exercise_routines.time as time,
                                                     exercise_routines.distance as distance"
                                                  )
    completed_goals = ActiveRecord::Base.connection.execute(<<-SQL)
      SELECT fitness_goals.*, 
        exercises.name as exercise_name,
        SUM(exercise_routines.repetitions) as total_repetitions
      FROM fitness_goals
      INNER JOIN exercises ON exercises.id = fitness_goals.exercise_id
      INNER JOIN exercise_routines ON exercise_routines.exercise_id = exercises.id
      INNER JOIN completed_exercise_routines ON completed_exercise_routines.exercise_routine_id = exercise_routines.id
      WHERE completed_exercise_routines.member_id = fitness_goals.member_id
        AND fitness_goals.member_id = #{ActiveRecord::Base.sanitize_sql(@member.id)}
        AND (exercises.has_weight IS FALSE OR (exercises.has_weight IS TRUE AND exercise_routines.weight = fitness_goals.weight))
        AND (exercises.has_time IS FALSE OR (exercises.has_time IS TRUE AND exercise_routines.time = fitness_goals.time))
        AND (exercises.has_distance IS FALSE OR (exercises.has_distance IS TRUE AND exercise_routines.distance = fitness_goals.distance))
      GROUP BY fitness_goals.id, exercises.name
      HAVING SUM(exercise_routines.repetitions) >= fitness_goals.repetitions
    SQL

    @completed_goals = completed_goals.map do |result|
      result.to_h
    end

    @bmi = (@member.weight && @member.height) ? (@member.weight / ((@member.height / 100.0) * (@member.height / 100.0))).round(2) : nil
    @bsa = @member.height && @member.weight ? (Math.sqrt((@member.height * @member.weight) / 3600)).round(2) : nil
  end

  def bills
    @member = Member.find(current_user.roleable_id)
    @bills = @member.bills.order(date: :desc)
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to member_url(@member), notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to member_url(@member), notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy!

    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :date_of_birth, :height, :weight)
    end
end
