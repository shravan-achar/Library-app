# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# r1 = Room.create(:number => 11, :capacity=>4, :building=>0, :booked=>false)
# r2 = Room.create(:number => 12, :capacity=>6, :building=>0, :booked=>false)
# r3 = Room.create(:number => 13, :capacity=>12, :building=>0, :booked=>false)
# #
# # r4 = Room.create(:number => 21, :capacity=>4, :building=>1, :booked=>false)
# # r5 = Room.create(:number => 22, :capacity=>6, :building=>1, :booked=>false)
# # r6 = Room.create(:number => 23, :capacity=>12, :building=>1, :booked=>false)
#
m1 = Member.create(:email=>"gpollep@ncsu.edu",:password_digest=>"abc",:name=>"Guru")
m2 = Member.create(:email=>"bachar@ncsu.edu",:password_digest=>"def",:name=>"Shravan")

(1..3).each do |x|
  b1 = Booking.create( :Participants=>"bachar@ncsu.edu", :StartTime=>Time.now+4.hours, :EndTime=>Time.now+6.hours, :Booked=>true, :member_id=>2, :room_id=>10+x)
end
