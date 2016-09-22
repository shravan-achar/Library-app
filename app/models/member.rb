class Member < ApplicationRecord
  has_many :bookings
  has_many :rooms, :through => :bookings

  serialize :history, Array
end
