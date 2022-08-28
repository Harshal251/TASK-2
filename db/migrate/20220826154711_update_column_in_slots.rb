class UpdateColumnInSlots < ActiveRecord::Migration[7.0]
  def change
    change_column :slots, :time, :float
  end
end
