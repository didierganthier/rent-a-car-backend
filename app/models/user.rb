class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :destroy
  has_many :cars, through: :reservations

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid email address' }
  validates :password, presence: true, length: { minimum: 6 }
end
