class Message < ActiveRecord::Base

  belongs_to :user
  scope :by_user_id, ->{ select("max(id) as id, user_id, count(message) as qty").group(:user_id)}

end
