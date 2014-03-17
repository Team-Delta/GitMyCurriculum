# Controller for the profile
class ProfileController < ApplicationController
  def load
    @email = Digest::MD5.hexdigest(current_user.email.strip.downcase)
    @peers = current_user.peers
    @month = Date::MONTHNAMES[current_user.created_at.month]
    @year =  current_user.created_at.year
    @day =   current_user.created_at.day
    @created_curricula = Curricula.find_curricula_for_creator current_user
    @contributed_curricula = Curricula.find_curricula_for_contributor current_user
  end

  def edit
    @info = User.all
  end

  private

  def post_params
    params.require(:description, :occupation).permit(:description, :occupation)
  end
end
