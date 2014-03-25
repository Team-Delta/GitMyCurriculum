# Controller the dashboard features
class DashboardController < ApplicationController
  include NotificationManager
  include GitFunctionality

  # loads dashboard for current user
  def dashboard_main
    # gets a list of all of the current user's curricula
    begin
      @created_curricula = Curricula.find_curricula_for_creator current_user
      @contributed_curricula = Curricula.find_curricula_for_contributor current_user
      @followed_curricula = Curricula.find_curricula_for_follower current_user
      check_for_new_commits
    rescue => e
      logger.error e.message
    end

    # get a list of the current user's latest notifications
    @notifications = []
    @created_curricula.each do |c|
      c.notifications.includes(:curricula, :author).find_each do |n|
        @notifications.push(n)
      end
    end

    # gets a list of the off the curricula that a user has contributed to
    @contributed_curricula.each do |c|
      c.curricula.notifications.includes(:curricula, :author).find_each do |n|
        @notifications.push(n)
      end
    end

    # sort notifications by most recent
    @notifications = @notifications.sort_by { |n| n[:created_at] }
    @notifications = @notifications.reverse
  end

  private

  def check_for_new_commits
    @created_curricula.each do |c|
      @git = get_bare_repo c
      check_for_subfunction(c, @git)
    end

    @contributed_curricula.each do |c|
      @git = get_bare_repo c.curricula
      check_for_subfunction(c, @git)
    end
  end
# Subfunction to get rid of duplication
  def check_for_subfunction(c, git)
    @log = git.log
    @log.each do |l|
      notification = c.notifications.where('commit_id = ?', l.sha[0..8]).first
      @user = User.find_user_by_email l.author.email
      create_notification_for(0, @user, c, git.branch.to_s, l) if notification.nil?
    end
  end
end
