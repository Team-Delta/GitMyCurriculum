module GitFunctionality
  # Manages deleting commits for git funcitonality
  class DeleteCommit
    # deletes a save from a curriculum
    #
    # +curriculum+:: to delete a save from
    # +commit_id+:: id of the save to delete
    def delete_commit(curriculum, commit_id)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo curriculum
      commit = working_repo.gcommit(commit_id)
      Notification.where('commit_id = ?', ::GitFunctionality::Path.new.short_sha(commit.sha)).destroy_all
      working_repo.reset_hard(commit.parent.sha)
      system("cd #{Rails.root}/repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}; git push origin master --force")
    end
  end
end
