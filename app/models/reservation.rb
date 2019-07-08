class Reservation < ApplicationRecord
  belongs_to :space
  belongs_to :member
  has_one :user, through: :member
end
