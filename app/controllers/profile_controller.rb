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
    @followed_curricula = Curricula.find_curricula_for_follower current_user
  end

  def edit
    @info = User.all
  end

  def p_c_unfollow
    @curricula = Curricula.find_by cur_name: params[:curname]
    if current_user
      FollowingCurricula.where('user_id=? AND curricula_id=?', current_user.id, @curricula.id).destroy_all
      flash[:success] = "You are no longer following #{@curricula.cur_name}."
    else
      flash[:error] = "You must login to unfollow #{@curricula.cur_name}.".html_safe
    end
    redirect_to profile_load_path(tab: 'following')
  end

  private

  def post_params
    params.require(:description, :occupation).permit(:description, :occupation)
  end
end
