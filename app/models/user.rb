class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  has_many :groups, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :login_logs, dependent: :destroy
  has_secure_token :activation_token
  has_secure_token :password_reset_token
end

