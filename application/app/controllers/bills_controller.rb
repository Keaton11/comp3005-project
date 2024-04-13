class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show edit update destroy ]
  before_action :set_member, only: %i[ index pay ]
  protect_from_forgery except: [:create, :update, :destroy], if: -> { request.format.json? }

  # GET /bills or /bills.json
  def index
    @bills = Bill.all
  end

  # GET /bills/1 or /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  def pay
    @bill = Bill.find(params[:id])
    if @bill.update(paid: true)
      redirect_to bills_members_path(@member), notice: 'Bill paid successfully.'
    else
      redirect_to bills_members_path(@member), alert: 'Failed to pay the bill.'
    end
  end

  def staff_pay
    @bill = Bill.find(params[:id])
    if @bill.update(paid: true)
      redirect_to bills_staffs_path, notice: 'Bill paid successfully.'
    else
      redirect_to bills_staffs_path, alert: 'Failed to pay the bill.'
    end
  end

  def staff_remove_payment
    @bill = Bill.find(params[:id])
    if @bill.update(paid: false)
      redirect_to bills_staffs_path, notice: 'Bill payment removed successfully.'
    else
      redirect_to bills_staffs_path, alert: 'Failed to remove payment from bill.'
    end
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills or /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully created." }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully updated." }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1 or /bills/1.json
  def destroy
    @bill.destroy!

    respond_to do |format|
      format.html { redirect_to bills_url, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete_personal_fitness_class
    member = Member.find(params[:member_id])
    id = params[:id]
    bills = member.bills.where("name LIKE ?", "Fitness Class (Personal): #{id}")
    bills.destroy_all

    respond_to do |format|
      format.html { redirect_to fitness_classes_url, notice: 'Fitness class bills were successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def delete_group_fitness_class
    member = Member.find(params[:member_id])
    id = params[:id]
    bills = member.bills.where("name LIKE ?", "Fitness Class (Group): #{id}")
    bills.destroy_all

    respond_to do |format|
      format.html { redirect_to fitness_classes_url, notice: 'Fitness class bills were successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def set_member
      @member = Member.find(current_user.roleable_id)
    end

    # Only allow a list of trusted parameters through.
    def bill_params
      params.require(:bill).permit(:name, :cost, :member_id, :date, :paid)
    end
end
