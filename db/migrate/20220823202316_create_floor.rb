class CreateFloor < ActiveRecord::Migration[7.0]
  def change
    create_table :floors do |t|
      t.integer :floorno

      t.timestamps
    end
  end
end
