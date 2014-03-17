# Module containing extracted ruby-git code
module GitFunctionality
  def create_bare_repo(curriculum)
    Git.init("repos/#{curriculum.creator.username}/#{@curriculum.cur_name}", bare: true)
  end

  def create_working_directory(curriculum)
    bare_path = get_bare_path(curriculum)
    working_path = get_working_path(curriculum)
    Git.clone(bare_path, working_path)
  end

  def fork_repo(original, fork)
    Dir.mkdir("#{Rails.root}/repos/#{fork.creator.username}/#{fork.cur_name}")
    path = get_bare_path(original)
    Git.clone(path, '.git', path: "#{Rails.root}/repos/#{fork.creator.username}/#{fork.cur_name}", bare: true)
  end

  def create_initial_save(curriculum, fork)
    case fork
    when true
      filename = 'forkfile.doc'
      message = 'First save on forked project'
    when false
      filename = 'testfile.doc'
      message = 'First save'
    end
    path = get_working_path(curriculum)
    repo = Git.open(path)
    File.open("#{path}/#{filename}", 'w') { |f| f.write('Temporary document: can be deleted.') }
    repo.add(all: true)
    repo.commit_all(message)
    repo.push
  end

  def get_bare_path(curriculum)
    Rails.root + curriculum.path
  end

  def get_working_path(curriculum)
    "#{Rails.root}/repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}"
  end

  def configure_user_info(curriculum, user)
    path = get_working_path(curriculum)
    repo = Git.open(path)
    repo.config('user.name', user.username)
    repo.config('user.email', user.email)
  end

  def short_sha(commit_id)
  end
end
