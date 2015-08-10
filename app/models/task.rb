class Task < ActiveRecord::Base
  validates :title, presence: true
  validates :user_id, presence: true
end
