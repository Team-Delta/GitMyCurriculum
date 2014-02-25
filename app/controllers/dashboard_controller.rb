# Controller the dashboard features
class DashboardController < ApplicationController
  def dashboard_main
    @created_curricula = Curricula.where('creator_id = ?', current_user.id)
    @contributed_curricula = UserCurricula.joins(:curricula).where('user_id=? AND curriculas.creator_id!=?', current_user.id, current_user.id)
  end
end
