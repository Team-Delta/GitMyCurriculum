module GitFunctionality
  # Manages merging for git funcitonality
  class Merge
    # joins 2 streams
    #
    # loads the working
    # pulls on master then the other branch for commit history
    # merges the 2 branches
    # pushes the code up
    def merge(curriculum, merging_from)
      work = ::GitFunctionality::Repo.new.get_working_repo(curriculum)
      work.fetch
      work.pull
      work.checkout(merging_from)
      work.pull
      work.checkout('master')
      work.merge(merging_from)
      work.push
    end
  end
end
