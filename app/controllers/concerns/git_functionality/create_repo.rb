module GitFunctionality
  # Manages repos for git funcitonality
  class CreateRepo
    # generates a bare repository
    #
    # +curriculum+:: name for new curriculum
    def create_bare_repo(curriculum)
      Git.init("repos/#{curriculum.creator.username}/#{curriculum.cur_name}", bare: true)
    end

    # creates working directory for curriculum
    #
    # +curriculum+:: to create directory for
    # +user+:: who owns working dir
    def create_working_directory(curriculum, user)
      working_repo = Git.clone(::GitFunctionality::Path.new.get_bare_path(curriculum), ::GitFunctionality::Path.new.get_working_path(curriculum))
      working_repo.config('user.name', user.username)
      working_repo.config('user.email', user.email)
    end
  end
end
