class User < ApplicationRecord
  has_secure_password
  has_many :ratings
  has_many :contents, through: :ratings

  validates :email, uniqueness: true
end
