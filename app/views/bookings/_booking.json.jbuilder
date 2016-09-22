json.extract! booking, :id, :RoomId, :ResrvedByMember, :Member, :StartTime, :EndTime, :Booked, :created_at, :updated_at
json.url booking_url(booking, format: :json)