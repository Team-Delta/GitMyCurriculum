# controller for users
class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @peers = @user.peers
    @created_curricula = Curricula.where('creator_id = ?', @user.id)
    @contributed_curricula = UserCurricula.where('user_id=? AND createdCurricula.creator_id!=?', @user.id, @user.id)
    @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', @user.id, @user.id)
  end

end
