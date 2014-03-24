# Manager for creating notifications
module NotificationManager
  def create_notification_for(type, author, curriculum, branch = nil, commit = nil)
    @notification = Notification.new
    @notification.attributes = { notification_type: type, author: author, curricula: curriculum }
    @notification.attributes = { commit_id: commit.sha[0..8], created_at: commit.author.date.strftime('%y-%m-%d'), message: commit.message, stream: branch } unless commit.nil?
    @notification.save
  end
end
