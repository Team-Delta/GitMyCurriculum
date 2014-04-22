# controller for creating, loading, and editing a curricula
class CurriculaController < ApplicationController
  include NotificationManager
  # show curriculum based on curriculum id from uri param
  def show
    @curriculum = Curricula.find_by_id(params[:id])
    @git = ::GitFunctionality::Repo.new.get_bare_repo @curriculum
    @git_working = ::GitFunctionality::Repo.new.get_working_repo @curriculum
    @git_working.pull
    @branches = @git.branches
    path_properties = { name: "#{@curriculum.creator.username}", path: profile_load_path(id: @curriculum.creator.username) }
    path_properties2 = { name: "#{@curriculum.cur_name}", path: curricula_path(id: @curriculum.id) }
    @path = []
    @path.push << path_properties << path_properties2

    begin
      commit = File.read("repos/#{@curriculum.creator.username}/#{@curriculum.cur_name}/.git/refs/heads/master")
      @branch = 'master'

      tree = @git.gtree(commit[0..-2])

      @child_trees = tree.trees
      @child_blobs = tree.blobs
    rescue => e
      logger.error e.message
      flash[:error] = 'It appears that your project does not have any commits. You have no branches or objects to display.'
      @branch = 'master'
    end
  end

  def grab_tree_folder
    @counter = 0
    @curriculum = Curricula.find_by_id(params[:id])
    @git = ::GitFunctionality::Repo.new.get_bare_repo(@curriculum)
    @branch = params[:branch]
    tree = @git.gtree(params[:tree])
    @child_trees = tree.trees
    @child_blobs = tree.blobs
    path_properties = { name: "#{params[:name]}", path: open_folder_curricula_path(id: @curriculum.id, branch: @branch, tree: params[:tree], path: params[:path], name: params[:name]) }
    @path = params[:path]
    @path.append(path_properties)
    respond_to do |format|
      format.js
    end
  end

  def grab_file_contents
    @counter = 0
    @curriculum = Curricula.find_by_id(params[:id])
    @git = ::GitFunctionality::Repo.new.get_bare_repo(@curriculum)
    @blob = @git.gblob(params[:blob])
    @name = params[:name]
    path_properties = { name: "#{@name}", path: open_file_curricula_path(params) }
    @path = params[:path]
    @path.push(path_properties)
    respond_to do |format|
      format.js
    end
  end

  def new
  end

  # creates a new curriculum
  def create
    @user = current_user
    @curriculum = Curricula.new(curricula_params)
    @curriculum.attributes = { creator: @user, path: "repos/#{@user.username}/#{@curriculum.cur_name}/.git" }
    @curriculum.users << @user

    ::GitFunctionality::CreateRepo.new.create_bare_repo(@curriculum)
    ::GitFunctionality::CreateRepo.new.create_working_directory(@curriculum, @user)
    ::GitFunctionality::CreateInitialCommit.new.create_initial_commit(@curriculum, false)

    flash[:success] = 'Successfully created curriculum' if @curriculum.save
    redirect_to dashboard_show_path
  end

  # generates a fork of a curriculum
  def fork
    @forked = Curricula.find_by_id(params[:id])
    @creator = @forked.creator

    @fork = Curricula.new
    @fork.attributes = { cur_name: @forked.cur_name, cur_description: @forked.cur_description,
                         path: "repos/#{current_user.username}/#{@forked.cur_name}/.git", creator: current_user }
    @fork.users << current_user

    ::GitFunctionality::ForkRepo.new.fork_repo(@forked, @fork)
    ::GitFunctionality::CreateRepo.new.create_working_directory(@fork, current_user)
    ::GitFunctionality::CreateInitialCommit.new.create_initial_commit(@fork, true)
    create_notification_for(3, @fork.creator, @forked)

    flash[:success] = 'Successfully forked curriculum' if @fork.save
    redirect_to dashboard_show_path
  end

  private

  def curricula_params
    params.require(:curricula).permit(:cur_name, :cur_description, :creator_id, :path, :featured)
  end
end
