module GitFunctionality
  # Manages forking for git funcitonality
  class ForkRepo
    # creates a fork of a curriculum
    #
    # +original+:: original curriculum object
    # +fork+:: new forked curriculum object
    def fork_repo(original, fork)
      Git.clone(::GitFunctionality::Path.new.get_bare_path(original), ::GitFunctionality::Path.new.get_bare_path(fork), bare: true)
      fork.build_forked_curricula(forked_to_curriculum_id: fork.id, forked_from_curriculum_id: original.id)
    end
  end
end
