class User < ActiveRecord::Base
  has_many :affirmations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  has_secure_password
end