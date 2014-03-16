# controller for creating, loading, and editing a curricula
class CurriculaController < ApplicationController
  # where to put the user to auto assign the creater/owner
  def show
    @curriculum = Curricula.find_by_id(params[:id])
    @creator = User.find(@curriculum.creator_id)

    get_git_repo_for @curriculum
    @git_working.pull
    @log = @git.log
    @branches = @git.branches

    begin
      if params.key?(:branch)
        commit = File.read("repos/#{@creator.username}/#{@curriculum.cur_name}/.git/refs/heads/#{params[:branch]}")
        @branch = params[:branch]
      else
        commit = File.read("repos/#{@creator.username}/#{@curriculum.cur_name}/.git/refs/heads/master")
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
    @creator = User.find(@curriculum.creator_id)

    get_git_repo_for @curriculum

    @branches = @git.branches

    @blob = @git.gblob(params[:blob])
  end

  def create
    if request.post?
      @curricula = Curricula.new(curricula_params)
      @user = User.find(current_user.id)
      @curricula.users << @user
      @curricula.creator = @user
      @curricula.path = "repos/#{current_user.username}/#{@curricula.cur_name}/.git"

      @g = Git.init("repos/#{current_user.username}/#{@curricula.cur_name}", bare: true)
      @gw = Git.clone(@g.repo, "repos/#{current_user.username}/#{@curricula.cur_name}/working/#{@curricula.cur_name}")
      @gw.config('user.name', @user.username)
      @gw.config('user.email', @user.email)

      File.open("#{Rails.root}/repos/#{current_user.username}/#{@curricula.cur_name}/working/#{@curricula.cur_name}/testfile.doc", 'w') { |f| f.write('Temporary document: can be deleted.') }
      @gw.add(all: true)
      @gw.commit_all('First save')
      @gw.push

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

  def fork
    @forked = Curricula.find_by_id(params[:id])
    @creator = @forked.creator

    @fork = Curricula.new
    @fork.cur_name = @forked.cur_name
    @fork.cur_description = @forked.cur_description
    @fork.users << current_user
    @fork.creator = current_user
    @fork.path = "repos/#{current_user.username}/#{@fork.cur_name}/.git"

    Dir.mkdir("#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}")

    @g = Git.clone("#{Rails.root}/#{@forked.path}", '.git', path: "#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}", bare: true)
    @gw = Git.clone(@g.repo, "repos/#{current_user.username}/#{@fork.cur_name}/working/#{@fork.cur_name}")
    @gw.config('user.name', current_user.username)
    @gw.config('user.email', current_user.email)

    File.open("#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}/working/#{@fork.cur_name}/forkfile.doc", 'w') { |f| f.write('Temporary document: can be deleted.') }
    @gw.add(all: true)
    @gw.commit_all('First forked stream save')
    @gw.push

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
