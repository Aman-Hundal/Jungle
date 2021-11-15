class User < ActiveRecord::Base
  has_secure_password # This is the line of code that gives our User model authentication methods via bcrypt.
  validates :first_name, :last_name, :email, presence: true
end
