class Booking < ApplicationRecord
  belongs_to :member
  belongs_to :room

  validates :member, :presence => true
  validates :room, :presence => true
end
