module GitFunctionality
  # Manages merging for git funcitonality
  class MergeRequests
    # joins 2 streams
    #
    # loads the working
    # pulls on master then the other branch for commit history
    # merges the 2 branches
    # pushes the code up
    def merge(join_request)
      work = ::GitFunctionality::Repo.new.get_working_repo(join_request.curricula)
      work.fetch
      work.pull
      work.checkout(join_request.source_stream)
      work.pull
      work.checkout(join_request.target_stream)
      work.merge(join_request.source_stream)
      work.branch(join_request.source_stream).delete
      work.push
    end

    def create_branch(curriculum, name)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(curriculum)
      working_repo.branch(name)
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
      zip_file_path(curriculum)
      working.config('user.name', user.username)
      working.config('user.email', user.email)
      working_repo.add(all: true)
      working.commit(message)
    end

    def compare_branches(join_request)
      # run diffs on the two separate branches
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(join_request.curricula)
      working_repo.gtree("HEAD^{tree}").diff()
    end

    def clean_up(join_request)
      working_repo = ::GitFunctionality::Repo.new.get_working_repo(join_request.curricula)
      working_repo.checkout(join_request.target_stream)
      working_repo.branch(join_request.source_stream).delete
    end

    private

    def zip_file_path(curriculum)
      file_path = Rails.root.join('repos', "#{@curriculum.creator.username}/#{@curriculum.cur_name}/#{@curriculum.cur_name}.zip")
      destination_path = Rails.root.join('repos', "#{@curriculum.creator.username}/#{@curriculum.cur_name}/working/#{@curriculum.cur_name}")
      Zip::ZipFile.open(file_path) do |zip_file|
        zip_file.each do |f|
          f_path = File.join(destination_path, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) { true }
        end
      end
    end
  end
end
