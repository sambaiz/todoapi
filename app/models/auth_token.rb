class AuthToken < ActiveRecord::Base
  validates :user_id, presence: true
  validates :token, presence: true
  validates :expired_at, presence: true
end
