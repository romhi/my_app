class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :author, class_name: User
  scope :by_user_id, ->{ select("max(id) as id, user_id, count(message) as qty, sum(user_read) as new").group(:user_id)}
  scope :new_for_admin, ->{ where("admin_read is null") }
  scope :new_for_user, -> user_id { where("user_id = ? and user_read is null", user_id) }
  validates_presence_of :user_id

end
