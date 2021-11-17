class User < ActiveRecord::Base
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  has_secure_password # This is the line of code that gives our User model authentication methods via bcrypt.
  validates :first_name, :last_name, :email, presence: true
  validates :password, :password_confirmation, presence:true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5}
end
