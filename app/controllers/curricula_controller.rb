# controller for creating, loading, and editing a curricula
class CurriculaController < ApplicationController
  include GitFunctionality

  # where to put the user to auto assign the creater/owner
  def show
    @curriculum = Curricula.find_by_id(params[:id])

    @git = get_bare_repo @curriculum
    @git_working = get_working_repo @curriculum
    @git_working.pull
    @log = @git.log
    @branches = @git.branches

    begin
      if params.key?(:branch)
        commit = File.read("repos/#{@curriculum.creator.username}/#{@curriculum.cur_name}/.git/refs/heads/#{params[:branch]}")
        @branch = params[:branch]
      else
        commit = File.read("repos/#{@curriculum.creator.username}/#{@curriculum.cur_name}/.git/refs/heads/master")
        @branch = 'master'
      end

      if params.key?(:tree)
        tree = @git.gtree(params[:tree])
      else
        tree = @git.gtree(commit[0..-2])
      end

      @child_trees = tree.trees
      @child_blobs = tree.blobs
    rescue => e
      logger.error e.message
      flash[:error] = 'It appears that your project does not have any commits. You have no branches or objects to display.'
      @branch = 'master'
    end
  end

  def showfile
    @curriculum = Curricula.find_by_id(params[:id])

    @git = get_bare_repo @curriculum

    @branches = @git.branches
    @blob = @git.gblob(params[:blob])
  end

  def create
    if request.post?
      @user = current_user
      @curriculum = Curricula.new(curricula_params)
      @curriculum.creator = @user
      @curriculum.users << @user
      @curriculum.path = "repos/#{@user.username}/#{@curriculum.cur_name}/.git"

      create_bare_repo(@curriculum)
      create_working_directory(@curriculum, @user)
      create_initial_save(@curriculum, false)

      flash[:success] = 'Successfully created curriculum' if @curriculum.save
      redirect_to dashboard_dashboard_main_path
    end
  end

  def edit
    @curricula = Curricula.find(params[:id])
    @get_contributors=Curricula.get_contributors @curricula
    
    if request.post?
      @curricula.update_attributes(curricula_params)
      redirect_to dashboard_dashboard_main_path
    end
  end

  def fork
    @forked = Curricula.find_by_id(params[:id])
    @creator = @forked.creator

    @fork = Curricula.new
    @fork.cur_name = @forked.cur_name
    @fork.cur_description = @forked.cur_description
    @fork.creator = current_user
    @fork.users << current_user
    @fork.path = "repos/#{current_user.username}/#{@forked.cur_name}/.git"

    fork_repo(@forked, @fork)
    create_working_directory(@fork, current_user)
    create_initial_save(@fork, true)

    flash[:success] = 'Successfully forked curriculum' if @fork.save
    redirect_to dashboard_dashboard_main_path
  end

  def commits
    @curriculum = Curricula.find_by_id(params[:id])
    @git = get_bare_repo @curriculum
    @commits = @git.log
  end

  def revert_save
    @curriculum = Curricula.find_by_id(params[:id])
    delete_save @curriculum, params[:commit_id]

    redirect_to c_commit_path(id: @curriculum.id)
  end

  def compare
    @curriculum = Curricula.find_by_id(params[:id])
    @git = get_bare_repo @curriculum
    @commit = @git.gcommit(params[:commit])

    begin
      @difftree = @git.gtree(@commit.parents.first).diff(@commit)
      @array = []
      @difftree.each { |i| @array.push(i) }
    rescue => e
      logger.error e.message
    end
  end

  private

  def curricula_params
    params.require(:curricula).permit(:cur_name, :cur_description, :creator_id, :path)
  end
end
