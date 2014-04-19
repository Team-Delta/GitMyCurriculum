module GitFunctionality
  # Manages commits for git funcitonality
  class CreateInitialCommit
    # creates an initial save
    #
    # +curriculum+:: curriculum object to save to
    # +fork+:: boolean is for save [true] forked or [false] new repo
    def create_initial_commit(curriculum, fork)
      case fork
      when true
        filename = 'forkfile.doc'
        message = 'First save on forked project'
      when false
        filename = 'testfile.doc'
        message = 'First save'
      end
      working_repo = ::GitFunctionality::Repo.new.get_working_repo curriculum
      File.open("#{working_repo.dir}/#{filename}", 'w') { |f| f.write('Temporary document: can be deleted.') }
      working_repo.add(all: true)
      working_repo.commit_all(message)
      working_repo.push
    end
  end
end
