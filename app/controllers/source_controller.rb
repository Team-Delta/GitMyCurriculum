# shows and adds sources
class SourceController < ApplicationController
  def show
    @curriculum = Curricula.find_by_id(params[:id])
    @sources = Source.grab_sources_for_curriculum @curriculum
  end

  def edit
    @curriculum = Curricula.find_by_id(params[:id])
    @source = Source.new(source_params)
    @source.creator = current_user
    @source.curricula = @curriculum
    if @source.save
      flash[:success] = 'Success'
    else
      flash[:danger] = 'Error! Try submitting again'
    end
    @sources = Source.grab_sources_for_curriculum @curriculum
    respond_to do |format|
      format.js
    end
  end

  private

  def source_params
    params.require(:source).permit(:link, :source_tag)
  end
end
