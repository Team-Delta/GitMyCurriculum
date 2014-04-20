# Calls archive and downloads a zip of the repository
class DownloadController < ApplicationController
  def download
    curriculum = Curricula.find_by_id(params[:id])
    file_path = "#{Rails.root}/repos/#{curriculum.creator.username}/#{curriculum.cur_name}/working/#{curriculum.cur_name}.zip"
    ::GitFunctionality::Archive.new.archive_folder(curriculum)
    send_file(file_path,
              filename: "#{curriculum.cur_name}",
              type: 'application/zip',
              disposition: 'attachment',
              stream: true,
              buffer_size: 4096)
  end
end
