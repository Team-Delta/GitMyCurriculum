module GitFunctionality
  # Manages repos for git funcitonality
  class Repo
    # load the bare curriculum
    #
    # +curriculum+:: curriculum object
    def get_bare_repo(curriculum)
      path = ::GitFunctionality::Path.new.get_bare_path curriculum
      Git.bare(path)
    end

    # load working curriculum
    #
    # +curriculum+:: curriculum object
    def get_working_repo(curriculum)
      working = ::GitFunctionality::Path.new.get_working_path curriculum
      Git.open(working)
    end
  end
end
