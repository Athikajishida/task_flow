class User < ApplicationRecord
  has_secure_password
  has_many :tasks
 
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
end
