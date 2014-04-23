module GitFunctionality
  # Manages merging for git funcitonality
  class MergeRequests
    require 'zip'
    # joins 2 streams
    #
    # loads the working
    # pulls on master then the other branch for commit history
    # merges the 2 branches
    # pushes the code up
    def merge(join_request)
      work = ::GitFunctionality::Repo.new.get_working_repo(join_request.curricula)
      work.checkout(join_request.target_stream)
      work.fetch
      work.pull
      work.merge(join_request.source_stream)
      work.branch(join_request.source_stream).delete
      work.push
    end

    def create_branch(curriculum, name)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(curriculum)
      working_repo.branch(name).checkout
    end

    def create_join_request(curriculum, user, message)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(curriculum)
      join_request = JoinRequest.new
      join_request.attributes = { creator: user, curricula: curriculum,
                                  target_stream: 'master',
                                  source_stream: user.username,
                                  message: message }
      join_request.save
      working_repo.pull('origin', 'master')
      working_repo.checkout(user.username)
      zip_file_path(curriculum, user.username)
      working_repo.config('user.name', user.username)
      working_repo.config('user.email', user.email)
      working_repo.add(all: true)
      working_repo.commit(message)
    end

    # run diffs on the two separate branches
    def compare_branches(join_request)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(join_request.curricula)
      master_commit = working_repo.branches['master'].gcommit
      user = User.find_by_id(join_request.creator_id)
      request_commit = working_repo.branches[user.username].gcommit
      working_repo.diff(master_commit, request_commit)
    end

    def clean_up(join_request)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(join_request.curricula)
      working_repo.checkout(join_request.target_stream)
      working_repo.branch(join_request.source_stream).delete
    end

    private

    def zip_file_path(curriculum, name)
      file_path = Rails.root.join('repos', "#{curriculum.creator.username}/#{curriculum.cur_name}/#{name}.zip")
      destination_path = Rails.root.join('repos', "#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}")
      Zip::File.open(file_path) do |zip_file|
        zip_file.each do |f|
          f_path = File.join(destination_path, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) { true }
        end
      end
    end
  end
end
