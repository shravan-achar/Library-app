class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :RoomId
      t.integer :ResrvedByMember
      t.integer :Member
      t.datetime :StartTime
      t.datetime :EndTime
      t.boolean :Booked

      t.timestamps
    end
  end
end
