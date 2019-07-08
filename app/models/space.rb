class Space < ApplicationRecord
  belongs_to :group
  has_one :reservation, dependent: :destroy
end
