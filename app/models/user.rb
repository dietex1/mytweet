 class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true , format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "must be a valid email address"}
  has_many :posts
  has_many :comments

 end
