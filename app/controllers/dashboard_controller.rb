# Controller the dashboard features
class DashboardController < ApplicationController
  include NotificationManager

  # loads dashboard for current user
  def show
    # gets a list of all of the current user's curricula
    begin
      @created_curricula = Curricula.find_curricula_for_creator current_user
      @contributed_curricula = Curricula.find_curricula_for_contributor current_user
      @followed_curricula = Curricula.find_curricula_for_follower current_user
      @combined_curricula = @created_curricula.concat(@contributed_curricula.curricula)
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
    @combined_curricula.each do |c|
      @git = ::GitFunctionality::Repo.new.get_bare_repo c
      @log = @git.log
      @log.each do |l|
        notification = c.notifications.where('commit_id = ?', l.sha[0..8]).first
        @user = User.find_user_by_email l.author.email
        create_notification_for(0, @user, c, @git.branch.to_s, l) if notification.nil?
      end
    end
  end
end
