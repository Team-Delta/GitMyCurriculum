# Manager for creating notifications
module NotificationManager
  # handles creation of a notification
  #
  # +type+:: of activity being generated
  # +param+:: author of the activity
  # +curriculum+:: that the activity is in
  # +branch+:: optional branch which activity occured on
  # +commit+:: optional commit object
  def create_notification_for(type, author, curriculum, branch = nil, commit = nil)
    @notification = Notification.new
    @notification.attributes = { notification_type: type, author: author, curricula: curriculum }
    if !commit.nil?
      time = Time.new
      @notification.attributes = { created_at: time.strftime('%y-%m-%d') }
    else
      @notification.attributes = { commit_id: commit.sha[0..8], created_at: commit.author.date.strftime('%y-%m-%d'), message: commit.message, stream: branch }
    end
    @notification.save
  end
end
