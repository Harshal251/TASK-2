# frozen_string_literal: true

# floor_controller
class FloorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_floor, only: %i[show update destroy]
  # GET /forms
  def index
    @floors = Floor.all
    render json: @floors
  end

  # GET /forms/1
  def show
    render json: gen_floor
  end

  # POST /forms
  def create
    # debugger
    if Floor.count <= 10
      f = params[:floor][:floorno].to_i
      for i in 1..f
        @floor = Floor.new(floor_params)
        @floor.floorno = i
        #  render json: gen_floor
        if @floor.save
        else
          render json: @floor.errors, status: :unprocessable_entity
        end

      end
    else
      render json: { message: 'Floor Limit Exceed!!' }
    end
    render json: floor_show
  end

  # PATCH/PUT /forms/1
  def update
    if @floor.update(floor_params)
      render json: @floor
    else
      render json: @floor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  def destroy
    @floor.destroy
    render json: floor_destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_floor
    @floor = Floor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def floor_params
    params.fetch(:floor, {}).permit(:floorno)
  end

  def gen_floor
    data = []
    data << {
      floor_id: @floor.id,
      floor_no: @floor.id,
      floor_created_at: @floor.created_at,
      floor_updated_at: @floor.updated_at,
      floor_slots_length: @floor.slots.length,
      floor_slots: gen_floor_slots
    }
    data
  end

  def gen_floor_slots
    data = []
    @floor.slots.each do |slot|
      data << {
        slot_id: slot.id, client_name: slot.clientname, car_number: slot.carnumber, car_color: slot.carcolor,
        status: slot.status, slot_created_at: slot.created_at, slot_updated_at: slot.updated_at
      }
    end
    data
  end

  def floor_destroy
    data = []
    data << {
      message: 'Floor Details Destroyed Successfully',
      floor_id: @floor.id
    }
    data
  end

  def floor_show
    data = []
    data << {
      message: 'Floors Created Successfully!!',
      Floors: Floor.all
    }
  end
end
