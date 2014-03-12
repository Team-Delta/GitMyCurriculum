# Controller the dashboard features
class DashboardController < ApplicationController
  def dashboard_main
    begin
      @created_curricula = Curricula.where('creator_id = ?', current_user.id)
      @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', current_user.id, current_user.id)
      
    rescue
    end
    check_for_new_commits
    @notifications = Array.new
    for c in @created_curricula
      c.notifications.find_each do |n|
        @notification = Hash.new
        if !n.message.nil?
          set_notification_hash(n.notification_type, n.message)
        end
      end
    end

    for c in @contributed_curricula
      c.curricula.notifications.find_each do |n|
        @notification = Hash.new
        if !n.message.nil?
          set_notification_hash(n.notification_type, n.message)
        end
      end
    end
  end

  private

  def check_for_new_commits
    for @c in @created_curricula
      path = Rails.root + @c.path
      @git = Git.bare(path)
      @log = @git.log
      for l in @log
        notification = @c.notifications.where('commit_id = ?', l.sha[0..8]).first
        if notification == nil
          create_notification_for l
        end
      end
    end

    for @c in @contributed_curricula
      path = Rails.root + @c.path
      @git = Git.bare(path)
      @log = @git.log
      for l in @log
        notification = @c.notifications.where('commit_id = ?', l.sha[0..8]).first
        if notification == nil
          create_notification_for l
        end
      end
    end
  end

  def create_notification_for(commit)
    @user = User.find_user_by_email commit.author.email
    @notification = Notification.new()
    @notification.author = @user
    @notification.notification_type = 0
    @notification.message = "#{@user.username} has saved to stream #{@git.branch.name} at #{@c.creator.username}/#{@c.cur_name}.\n#{commit.sha[0..8]} #{commit.message}"
    @notification.created_at = commit.author.date.strftime("%y-%m-%d")
    @notification.commit_id = commit.sha[0..8]
    @c.notifications << @notification
    @notification.save
  end

  def set_notification_hash (notif_type, message)
    @notification[:message] = message
    case notif_type
    when 0, 2, 3, 4
      @notification[:css_class] = 'bg-info text-primary'
    when 1
      @notification[:css_class] = 'bg-warning text-warning'
    when 5
       @notification[:css_class] = 'bg-success text-success'
    when 6
       @notification[:css_class] = 'bg-danger text-danger'
    else
       @notification[:css_class] = 'bg-info text-primary'
    end
    @notifications.push(@notification)
  end
end
