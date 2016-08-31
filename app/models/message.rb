class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :author, class_name: User
  scope :by_user_id, ->{ select("max(id) as id, user_id, count(message) as qty, sum(user_read) as new").group(:user_id)}
  scope :new_for_admin, ->{ where("admin_read is null") }
  scope :new_for_user, -> user_id { where("user_id = ? and user_read is null", user_id) }
  validates_presence_of :user_id

  after_create :send_notification

  def send_notification
    if author.admin?
      Messages.new_message(user).deliver
    else
      User.admins.each do |user|
      Messages.new_message(user).deliver
      end
    end
  end

end
