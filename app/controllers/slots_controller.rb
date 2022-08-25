class SlotsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_slot, only: %i[ show update destroy ]
  # GET /forms
  def index
    @slots = Slot.all
    render json: @slots
  end

  # GET /forms/1
  def show
    render json: @slot
  end

  # POST /forms
  def create
    @slot = Slot.new(slot_params)

    max_floor_length = 10
    if @slot.floor.slots.length < 10
      # @slot.floor_id = session[:floor_id]
      if @slot.save
        @slot.in = DateTime.now
        render json: @slot, status: :created
      else
        render json: @slot.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "slot limit exceeded" }
    end
  end

  # PATCH/PUT /forms/1
  def update
    if @slot.update(slot_params)
      @slot.out = DateTime.now
      render json: @slot
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  def destroy
    @slot.destroy
    render json: { message: "Details of Slot #{@slot.id} are deleted Successfully" }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slot
    @slot = Slot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def slot_params
    params.fetch(:slot, {}).permit(:clientname, :carnumber, :carcolor, :price, :slotno, :status, :in, :floor_id, :time)
  end
end
