# frozen_string_literal: true

# hgyh
class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.string :clientname
      t.integer :carnumber
      t.string :carcolor
      t.datetime :in
      t.datetime :out
      t.time :time
      t.decimal :price
      t.integer :floor_id
      t.integer :slotno
      t.string :status
      t.timestamps
    end
  end
end
