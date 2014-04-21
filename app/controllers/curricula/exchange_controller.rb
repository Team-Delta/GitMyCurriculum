# controller for exchanging files between client and server
class Curricula::ExchangeController < ApplicationController
  def upload
    @curriculum = Curricula.find_by_id(params[:id])
    if request.post?
      uploaded_io = params[:zip]
      begin
        if uploaded_io.content_type == 'application/zip'
          File.open(Rails.root.join('repos', "#{@curriculum.creator.username}/#{@curriculum.cur_name}", uploaded_io.original_filename), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          flash[:success] = 'File uploaded successfully'
        else
          flash[:error] = 'The uploaded file must be a zip'
        end
      rescue
        flash[:error] = 'File could not be uploaded.'
      end
      redirect_to dashboard_show_path
    end
  end
end
