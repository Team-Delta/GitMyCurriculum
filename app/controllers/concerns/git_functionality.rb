# Module containing extracted ruby-git code
module GitFunctionality
  def create_bare_repo(curriculum)
    Git.init("repos/#{curriculum.creator.username}/#{curriculum.cur_name}", bare: true)
  end

  def create_working_directory(curriculum, user)
    working_repo = Git.clone(get_bare_path(curriculum), get_working_path(curriculum))
    working_repo.config('user.name', user.username)
    working_repo.config('user.email', user.email)
  end

  def fork_repo(original, fork)
    Git.clone(get_bare_path(original), get_bare_path(fork), bare: true)
    fork.build_forked_curricula(forked_to_curriculum_id: fork.id, forked_from_curriculum_id: original.id)
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
    working_repo = get_working_repo curriculum
    File.open("#{working_repo.dir}/#{filename}", 'w') { |f| f.write('Temporary document: can be deleted.') }
    working_repo.add(all: true)
    working_repo.commit_all(message)
    working_repo.push
  end

  def delete_save(curriculum, commit_id)
    working_repo = get_working_repo curriculum
    commit = working_repo.gcommit(commit_id)
    Notification.where('commit_id = ?', short_sha(commit.sha)).destroy_all
    working_repo.reset_hard(commit.parent.sha)
    system("cd /repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}; git push origin master --force")
  end

  def get_bare_path(curriculum)
    Rails.root + curriculum.path
  end

  def get_working_path(curriculum)
    "#{Rails.root}/repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}"
  end

  def get_bare_repo(curriculum)
    path = get_bare_path curriculum
    Git.bare(path)
  end

  def get_working_repo(curriculum)
    working = get_working_path curriculum
    Git.open(working)
  end

  def short_sha(commit_id)
    commit_id[0..8]
  end
end
