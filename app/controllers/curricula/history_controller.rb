# controller for viewing commit history, comparing and deleting commits on a curricula
class Curricula::HistoryController < ApplicationController
  include NotificationManager

  # shows a commit history for the curricula
  def show
    @curriculum = Curricula.find_by_id(params[:id])
    @git = ::GitFunctionality::Repo.new.get_bare_repo(@curriculum)
    @commits = @git.log
  end

  # reverts a curriculum to a previous save
  def revert
    @curriculum = Curricula.find_by_id(params[:id])
    begin
      ::GitFunctionality::DeleteCommit.new.delete_commit(@curriculum, params[:commit])
      create_notification_for(7, current_user, @curriculum)
    rescue => e
      logger.error e.message
      flash[:error] = 'It appears that save has no parents.'
    end
    redirect_to curricula_history_path(id: @curriculum.id)
  end

  # compares two saves in a curriculum
  def compare
    @curriculum = Curricula.find_by_id(params[:id])
    @git = ::GitFunctionality::Repo.new.get_bare_repo(@curriculum)
    @commit = @git.gcommit(params[:commit])

    begin
      @difftree = @git.gtree(@commit.parents.first).diff(@commit)
      @array = []
      @difftree.each { |i| @array.push(i) }
    rescue => e
      logger.error e.message
    end
  end
end
