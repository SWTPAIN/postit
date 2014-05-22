class User < ActiveRecord::Base;
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, length: {minimum:3}, presence: true, on: :create #this mean the validation will only fire up on create action
end