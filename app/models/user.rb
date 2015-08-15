class User < ActiveRecord::Base
  has_secure_password
  has_many :auth_tokens

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum:6 }

end
