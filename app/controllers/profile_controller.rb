class ProfileController < ApplicationController

  def load

  end

  def edit
    @info = User.all
  end

  def create
    @info = User.new(post_params)

    @info.save
    redirect_to :back
  end

  private

  def post_params
    params.require(:description, :occupation).permit(:description, :occupation)
  end


end
