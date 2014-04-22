class Curricula::PullRequestController < ApplicationController
  def show_requests
    curriculum = Curricula.find_by_id(params[:id])
    @requests = JoinRequest.get_pull_request_for curriculum
  end

  def pull_request
    join_request = JoinRequest.find_by_id(params[:id])
    @diffs = ::GitFunctionality::MergeRequests.new.compare_branches join_request
    @array = []
    @diffs.each { |i| @array.push(i) }
  end

  def merge_request
    @join_request = JoinRequest.find_by_id(params[:id])
    if params[:accept]
      ::GitFunctionality::MergeRequests.new.merge @join_request
      @join_request.status = true
    elsif params[:deny]
      ::GitFunctionality::MergeRequests.new.clean_up @join_request
      @join_request.status = false
    end
    @join_request.closed = true
    @join_request.save
  end
end
