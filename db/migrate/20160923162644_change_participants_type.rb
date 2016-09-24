class ChangeParticipantsType < ActiveRecord::Migration[5.0]
  def change
    change_column :bookings, :Participants, :string
    remove_column :bookings, :Booked
  end
end
