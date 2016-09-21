class Member < ApplicationRecord
  serialize :history, Array
end
