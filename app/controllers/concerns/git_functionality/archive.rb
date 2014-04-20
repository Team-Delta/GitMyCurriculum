module GitFunctionality
  # Zips the working directory of a repository
  class Archive
    def archive_folder(curriculum)
      git_working = ::GitFunctionality::Repo.new.get_working_repo curriculum
      commit = File.read("repos/#{curriculum.creator.username}/#{curriculum.cur_name}/.git/refs/heads/master")
      tree = git_working.gtree(commit[0..-2])
      git_working.archive tree, "#{curriculum.cur_name}.zip"
    end
  end
end
