module GitFunctionality
  # Manages path aspects for git funcitonality
  class Path
    # get the path to the bare curriculum
    #
    # +curriculum+:: curriculum object to find path for
    def get_bare_path(curriculum)
      Rails.root + curriculum.path
    end

    # get the path to the working curriculum
    #
    # +curriculum+:: curriculum object to find path for
    def get_working_path(curriculum)
      "#{Rails.root}/repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}"
    end

    # shortens 32 character id to 8 characters
    #
    # +commit_id+:: id to shorten
    def short_sha(commit_id)
      commit_id[0..8]
    end
  end
end
