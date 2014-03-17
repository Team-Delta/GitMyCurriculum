# controller for creating, loading, and editing a curricula
class CurriculaController < ApplicationController
  include GitFunctionality
  # where to put the user to auto assign the creater/owner
  def show
    @curriculum = Curricula.find_by_id(params[:id])

    get_git_repo_for @curriculum
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
    rescue
      flash[:error] = 'It appears that your project does not have any commits. You have no branches or objects to display.'
      @branch = 'master'
    end
  end

  def showfile
    @curriculum = Curricula.find_by_id(params[:id])

    get_git_repo_for @curriculum

    @branches = @git.branches
    @blob = @git.gblob(params[:blob])
  end

  def create
    if request.post?
      @curriculum = create_curriculum(curricula_params)
      @user = current_user

      create_bare_repo(@curriculum)
      create_working_directory(@curriculum)
      configure_user_info(@curriculum, @user)
      create_initial_save(@curriculum, false)

      flash[:success] = 'Successfully created curriculum' if @curriculum.save
      redirect_to dashboard_dashboard_main_path
    end
  end

  def edit
    @curricula = Curricula.find(params[:id])
    if request.post?
      @curricula.update_attributes(curricula_params)
      redirect_to dashboard_dashboard_main_path
    end
  end

  def fork
    @forked = Curricula.find_by_id(params[:id])
    @creator = @forked.creator

    @fork = create_curriculum(cur_name: @forked.cur_name, cur_description: @forked.cur_description)
    @user = current_user

    fork_repo(@forked, @fork)
    create_working_directory(@fork)
    configure_user_info(@fork, current_user)
    create_initial_save(@fork, true)

    flash[:success] = 'Successfully forked curriculum' if @fork.save
    redirect_to dashboard_dashboard_main_path
  end

  def commits
    @curriculum = Curricula.find_by_id(params[:id])
    get_git_repo_for @curriculum
    @commits = @git.log
  end

  def revert_save
    @curriculum = Curricula.find_by_id(params[:id])
    @commit = params[:commit_id]
    get_git_repo_for @curriculum
    @commit = @git_working.gcommit(@commit)
    Notification.where('commit_id = ?', @commit.sha[0..8]).destroy_all
    @git_working.reset_hard(@commit.parent.sha)
    system("cd /repos/#{@curriculum.creator.username}/#{@curriculum.cur_name}/working/#{@curriculum.cur_name}; git push origin master --force")

    redirect_to c_commit_path(id: @curriculum.id)
  end

  private

  def create_curriculum(hash = {})
    curriculum = Curricula.new(hash)
    user = current_user
    curriculum.users << user
    curriculum.creator = user
    curriculum.path = "repos/#{user.username}/#{curriculum.cur_name}/.git"
    curriculum
  end

  def get_git_repo_for(curriculum)
    @user = User.find_by_id(current_user.id)
    path = Rails.root + curriculum.path
    wp = "repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}"
    @git = Git.bare(path)
    @git_working = Git.open(wp)
    @git_working.config('user.name', @user.username)
    @git_working.config('user.email', @user.email)
  end

  def curricula_params
    params.require(:curricula).permit(:cur_name, :cur_description, :creator_id, :path)
  end
end
