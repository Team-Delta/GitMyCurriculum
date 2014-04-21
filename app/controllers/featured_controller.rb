# load the featured page
class FeaturedController < ApplicationController
  def show
    @featured_curricula = Curricula.find_curricula_for_featured true
  end

  def add_featured
    curriculum = Curricula.find_by_id(params[:id])
    curriculum.featured = true
    curriculum.save
    redirect_to dashboard_show_path
  end

  def remove_featured
    curriculum = Curricula.find_by_id(params[:id])
    curriculum.featured = false
    curriculum.save
    redirect_to dashboard_show_path
  end
end
