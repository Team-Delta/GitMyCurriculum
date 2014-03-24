# Manager for creating notifications
module NotificationManager
  # handles create of a notification
  #
  # +type+:: of activity being generated
  # +param+:: author of the activity
  # +curriculum+:: that the activity is in
  # +branch+:: optional branch which activity occured on
  # +commit+:: optional commit number
  def create_notification_for(type, author, curriculum, branch = nil, commit = nil)
    @notification = Notification.new
    @notification.attributes = { notification_type: type, author: author, curricula: curriculum }
    @notification.attributes = { commit_id: commit.sha[0..8], created_at: commit.author.date.strftime('%y-%m-%d'), message: commit.message, stream: branch } unless commit.nil?
    @notification.save
  end
end
