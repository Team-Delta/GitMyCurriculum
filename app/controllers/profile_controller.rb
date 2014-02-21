# Controller for the profile
class ProfileController < ApplicationController
  def load
    @email = Digest::MD5.hexdigest(current_user.email.strip.downcase)
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
