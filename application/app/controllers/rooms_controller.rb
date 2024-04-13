class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /available_rooms
  def available_rooms
    start_time = params[:start_time]
    end_time = params[:end_time]
    required_capacity = params[:member_count].to_i

    overlapping_room_ids = Room.joins(:fitness_classes)
                               .left_joins(fitness_classes: :fitness_class_members)
                               .where("(fitness_classes.start_time < :end_time AND fitness_classes.end_time > :start_time)",
                                      {start_time: start_time, end_time: end_time})
                               .select("rooms.id")
                               .group("rooms.id")
                               .having("COUNT(DISTINCT fitness_classes.id) + COALESCE(SUM(fitness_class_members.id), 0) + :required_capacity > rooms.maximum_occupancy",
                                       {required_capacity: required_capacity})
                               .pluck(:id)

    @available_rooms = Room.where.not(id: overlapping_room_ids)

    render json: @available_rooms
  end

  def bookings
    @fitness_classes = FitnessClass.all.map(&:import_details)
    @rooms = Room.all
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_class_room
    fitness_class = FitnessClass.find(params[:class_id])
    fitness_class.update(room_id: params[:room_id])

    if fitness_class.update(room_id: params[:room_id])
      redirect_to bookings_rooms_path, notice: 'Room updated successfully.'
    else
      redirect_to bookings_rooms_path, alert: 'Failed to update room.'
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:maximum_occupancy)
    end
end
