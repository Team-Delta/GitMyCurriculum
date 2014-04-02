# Controller for the profile
class ProfileController < ApplicationController
  # Load a user's profile
  def load
    if !params[:username]
      @user = current_user
    else
      @user = User.find_by_username(params[:username])
    end
    @email = Digest::MD5.hexdigest(@user.email.strip.downcase)
    @peers = @user.peers
    @month = Date::MONTHNAMES[@user.created_at.month]
    @year =  @user.created_at.year
    @day =   @user.created_at.day
    @created_curricula = Curricula.find_curricula_for_creator @user
    @contributed_curricula = Curricula.find_curricula_for_contributor @user
    @followed_curricula = Curricula.find_curricula_for_follower @user
  end
end
