class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :number
      t.string :capacity
      t.string :building
      t.boolean :booked

      t.timestamps
    end
  end
end
