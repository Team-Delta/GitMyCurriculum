class Curricula::PullRequestController < ApplicationController
  include CommentManager
  include NotificationManager

  def show_requests
    @curriculum = Curricula.find_by_id(params[:id])
    @requests = JoinRequest.get_pull_requests_for @curriculum
  end

  def pull_request
    @join_request = JoinRequest.find_by_id(params[:id])
    @comments = @join_request.comments
    @curriculum = @join_request.curricula
    @diffs = ::GitFunctionality::MergeRequests.new.compare_branches @join_request
    @array = []
    @diffs.each { |i| @array.push(i) }
  end

  def merge_request
    @join_request = JoinRequest.find_by_id(params[:id])
    if params[:accept]
      ::GitFunctionality::MergeRequests.new.merge @join_request
      @join_request.status = true
      create_notification_for(11, @join_request.creator, @join_request.curricula)
    elsif params[:deny]
      ::GitFunctionality::MergeRequests.new.clean_up @join_request
      @join_request.status = false
      create_notification_for(12, @join_request.creator, @join_request.curricula)
    end
    @join_request.closed = true
    @join_request.save
    redirect_to dashboard_show_path
  end

  def comment
    join_request = JoinRequest.find_by_id(params[:id])

    if params[:parent]
      create_comment_for(current_user, join_request, comment_params[:message], comment_params[:parent])
    else
      create_comment_for(current_user, join_request, comment_params[:message])
    end

    puts params[:message]

    redirect_to curricula_join_request_path(id: join_request.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :parent)
  end
end
