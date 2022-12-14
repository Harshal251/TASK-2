# frozen_string_literal: true

# slots_controller
class SlotsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_slot, only: %i[show update destroy]
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
    if @slot.floor.slots.length < 10
      if @slot.save
        @slot.in = DateTime.now
        @slot.save
        render json: @slot, status: :created
      else
        render json: @slot.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'slot limit exceeded' }
    end
  end

  def update
    if @slot.update(slot_params)
      @slot.slotno = @slot.id
      @slot.out = DateTime.now
      @slot.time = (@slot.out.to_time.to_i - @slot.in.to_time.to_i).to_f / 60
      @slot.price = @slot.time / 60 * 100 # price for 1 hour is 100
      @slot.save
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
