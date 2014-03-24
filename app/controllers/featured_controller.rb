# load the featured page
class FeaturedController < ApplicationController
  def load
    @featured_curriculua = Curricula.find_curricula_for_featured false
  end
end