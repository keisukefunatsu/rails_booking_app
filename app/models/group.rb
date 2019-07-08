class Group < ApplicationRecord
  belongs_to :user
  has_many :spaces, dependent: :destroy
  has_many :members, dependent: :destroy
end
