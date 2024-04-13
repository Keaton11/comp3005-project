class FitnessClassMembersController < ApplicationController
  before_action :set_fitness_class_member, only: %i[ show edit update destroy ]
  protect_from_forgery except: [:create, :update, :destroy], if: -> { request.format.json? }

  # GET /fitness_class_members or /fitness_class_members.json
  def index
    @fitness_class_members = FitnessClassMember.all
  end

  # GET /fitness_class_members/1 or /fitness_class_members/1.json
  def show
  end

  # GET /fitness_class_members/for_member_non_grouped/:member_id
  def for_member_non_grouped
    @fitness_classes = FitnessClass.joins(:fitness_class_members)
                                   .where(fitness_class_members: { member_id: params[:member_id] })
                                   .where(group_session: false)
                                   .distinct
    render json: @fitness_classes
  end

  # GET /fitness_class_members/new
  def new
    @fitness_class_member = FitnessClassMember.new
  end

  # GET /fitness_class_members/1/edit
  def edit
  end

  # POST /fitness_class_members or /fitness_class_members.json
  def create
    @fitness_class_member = FitnessClassMember.new(fitness_class_member_params)

    respond_to do |format|
      if @fitness_class_member.save
        format.html { redirect_to fitness_class_member_url(@fitness_class_member), notice: "Fitness class member was successfully created." }
        format.json { render :show, status: :created, location: @fitness_class_member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fitness_class_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fitness_class_members/1 or /fitness_class_members/1.json
  def update
    respond_to do |format|
      if @fitness_class_member.update(fitness_class_member_params)
        format.html { redirect_to fitness_class_member_url(@fitness_class_member), notice: "Fitness class member was successfully updated." }
        format.json { render :show, status: :ok, location: @fitness_class_member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fitness_class_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fitness_class_members/1 or /fitness_class_members/1.json
  def destroy
    @fitness_class_member.destroy!

    respond_to do |format|
      format.html { redirect_to fitness_class_members_url, notice: "Fitness class member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # DELETE /fitness_class_members/destroy_by_member_and_class/:fitness_class_id/:member_id
  def destroy_by_member_and_class
    fitness_class_id = params[:fitness_class_id]
    member_id = params[:member_id]

    fitness_class_members = FitnessClassMember.where(fitness_class_id: fitness_class_id, member_id: member_id)

    if fitness_class_members.exists?
      fitness_class_members.destroy_all
      render json: { message: 'All matching FitnessClassMember records were successfully destroyed.' }, status: :ok
    else
      render json: { error: 'No matching records found to delete.' }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitness_class_member
      @fitness_class_member = FitnessClassMember.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fitness_class_member_params
      params.require(:fitness_class_member).permit(:fitness_class_id, :member_id)
    end
end
