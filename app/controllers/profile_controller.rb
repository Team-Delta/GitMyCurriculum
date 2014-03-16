# Controller for the profile
class ProfileController < ApplicationController
  def load
    @email = Digest::MD5.hexdigest(current_user.email.strip.downcase)
    @peers = current_user.peers
    @month = current_user.created_at.month
    @year =  current_user.created_at.year
    @day =   current_user.created_at.day
    @created_curricula = Curricula.where('creator_id = ?', current_user.id)
    @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', current_user.id, current_user.id)
    case @month
    when 1
      @month = 'January'
    when 2
      @month = 'February'
    when 3
      @month = 'March'
    when 4
      @month = 'April'
    when 5
      @month = 'May'
    when 6
      @month = 'June'
    when 7
      @month = 'July'
    when 8
      @month = 'August'
    when 9
      @month = 'September'
    when 10
      @month = 'October'
    when 11
      @month = 'November'
    when 12
      @month = 'December'
    end
  end

  def edit
    @info = User.all
  end

  private

  def post_params
    params.require(:description, :occupation).permit(:description, :occupation)
  end
end
