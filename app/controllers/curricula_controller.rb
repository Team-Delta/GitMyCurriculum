# controller for creating, loading, and editing a curricula
class CurriculaController < ApplicationController
  # where to put the user to auto assign the creater/owner
  def show
    @curriculum = Curricula.find_by_id(params[:id])
    @creator = User.find(@curriculum.creator_id)

    path = Rails.root + @curriculum.path
    git = Git.bare(path)
    @log = git.log
    @branches = git.branches

    if params.key?(:branch)
      commit = File.read("repos/#{@creator.username}/#{@curriculum.cur_name}/.git/refs/heads/#{params[:branch]}")
      @branch = params[:branch]
    else
      commit = File.read("repos/#{@creator.username}/#{@curriculum.cur_name}/.git/refs/heads/master")
      @branch = 'master'
    end

    if params.key?(:tree)
      tree = git.gtree(params[:tree])
    else
      tree = git.gtree(commit[0..-2])
    end

    @child_trees = tree.trees
    @child_blobs = tree.blobs
  end

  def showfile
    @curriculum = Curricula.find_by_id(params[:id])
    @creator = User.find(@curriculum.creator_id)

    path = Rails.root + @curriculum.path
    git = Git.bare(path)

    @branches = git.branches

    @blob = git.gblob(params[:blob])
  end

  def create
    if request.post?
      @curricula = Curricula.new(curricula_params)
      @user = User.find(current_user.id)
      @curricula.users << @user
      @curricula.creator = @user
      @curricula.path = "repos/#{current_user.username}/#{@curricula.cur_name}/.git"

      @g = Git.init("repos/#{current_user.username}/#{@curricula.cur_name}", bare: true)

      flash[:success] = 'Successfully created curriculum' if @curricula.save
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

  def clone
    @user = User.find_by_username(params[:username])
    @curriculum = Curricula.where('creator_id=? AND cur_name=?', @user.id, params[:curriculum_name]).first
    @path = Rails.root + @curriculum.path

    redirect_to dashboard_dashboard_main_path
  end

  def commits
    @curriculum = Curricula.find_by_id(params[:id])
    path = Rails.root + @curriculum.path
    git = Git.bare(path)
    @commits = git.log
  end

  private

  def curricula_params
    params.require(:curricula).permit(:cur_name, :cur_description, :creator_id, :path)
  end
end
