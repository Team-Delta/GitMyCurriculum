# controller for creating, loading, and editing a curricula
class CurriculaController < ApplicationController
  # where to put the user to auto assign the creater/owner
  def show
    @curriculum = Curricula.find_by_id(params[:id])
    @creator = User.find(@curriculum.creator_id)

    path = Rails.root + @curriculum.path
    git = Git.bare(path)

    @branches = git.branches

    begin
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
    rescue
      # flash[:error] = "It appears that your project does not have any commits. You have no branches or objects to display."
      @branch = 'master'
    end
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
      @curricula.creator_id = @user.id
      @curricula.path = "repos/#{current_user.username}/#{@curricula.cur_name}/.git"

      @g = Git.init("repos/#{current_user.username}/#{@curricula.cur_name}", bare: true)

      clone = Git.clone("#{Rails.root}/#{@curricula.path}", 'clone.git', path: "#{Rails.root}/repos/#{current_user.username}/#{@curricula.cur_name}")
      File.open("#{Rails.root}/repos/#{current_user.username}/#{@curricula.cur_name}/clone.git/test.rb", 'w') { |f| f.write('write your stuff here') }
      clone.add(all: true)
      clone.commit_all('message')
      clone.push

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
    @creator = User.find(@forked.creator_id)

    @fork = Curricula.new
    @fork.cur_name = @forked.cur_name
    @fork.cur_description = @forked.cur_description
    @fork.users << current_user
    @fork.creator_id = current_user.id
    @fork.path = "repos/#{current_user.username}/#{@fork.cur_name}/.git"
    flash[:success] = 'Successfully forked curriculum' if @fork.save

    Dir.mkdir("#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}")

    Git.clone("#{Rails.root}/#{@forked.path}", '.git', path: "#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}", bare: true)

    clone = Git.clone("#{Rails.root}/#{@fork.path}", 'clone.git', path: "#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}")

    File.open("#{Rails.root}/repos/#{current_user.username}/#{@fork.cur_name}/clone.git/forktest", 'w') { |f| f.write('things') }
    clone.add(all: true)
    clone.commit_all('message')
    clone.push

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
