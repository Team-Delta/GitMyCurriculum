# Controller for the profile
class ProfileController < ApplicationController
  def load
    @email = Digest::MD5.hexdigest(current_user.email.strip.downcase)
    @peers = current_user.peers
    @created_curricula = Curricula.where('creator_id = ?', current_user.id)
    @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', current_user.id, current_user.id)
    @followed_curricula = FollowingCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', current_user.id, current_user.id)
  end

  def edit
    @info = User.all
  end

  private

  def post_params
    params.require(:description, :occupation).permit(:description, :occupation)
  end
end
