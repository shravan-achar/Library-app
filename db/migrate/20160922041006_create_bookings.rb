class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :Participants
      t.datetime :StartTime
      t.datetime :EndTime
      t.boolean :Booked

      t.belongs_to :member, index: true
      t.belongs_to :room, index: true

      t.timestamps
    end
  end
end
