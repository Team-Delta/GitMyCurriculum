# controller for exchanging files between client and server
class Curricula::ExchangesController < ApplicationController
  def upload
    @curriculum = Curricula.find_by_id(params[:id])
     authorize! :update, @curriculum
    if request.post?
      uploaded_io = params[:zip]
      # begin
      #   if uploaded_io.content_type == 'application/zip'
      #     File.open(Rails.root.join('repos', "#{@curriculum.creator.username}/#{@curriculum.cur_name}", uploaded_io.original_filename), 'wb') do |file|
      #       file.write(uploaded_io.read)
      #     end
      #     flash[:success] = 'File uploaded successfully'
      #     ::GitFunctionality::MergeRequests.new.create_join_request(@curriculum, current_user, "stuff")
      #   else
      #     flash[:error] = 'The uploaded file must be a zip'
      #   end
      # rescue
      #   flash[:error] = 'File could not be uploaded.'
      # end

      if uploaded_io.content_type == 'application/zip'
        File.open(Rails.root.join('repos', "#{@curriculum.creator.username}/#{@curriculum.cur_name}", "#{current_user.username}.zip"), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        flash[:success] = 'File uploaded successfully'
        ::GitFunctionality::MergeRequests.new.create_branch(@curriculum, current_user.username)
        ::GitFunctionality::MergeRequests.new.create_join_request(@curriculum, current_user, "stuff")
      else
        flash[:error] = 'The uploaded file must be a zip'
      end
      redirect_to dashboard_show_path
    end
  end

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
