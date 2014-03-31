# edits curricula
class EditCurriculaController < ApplicationController
  # updates the information of a curriculum
  def edit
    @curricula = Curricula.find(params[:id])
    @contributors = UserCurricula.get_contributors @curricula
    if request.post?
      @curricula.update_attributes(curricula_params)
      redirect_to dashboard_dashboard_main_path
    end
  end

  def update_contributors
    @curricula = Curricula.find_by_id(params[:curriculum])
    @contributor = User.find_user_by_username(params[:user])
    # @does_exist = UserCurricula.does_user_exist(@curricula, @contributor.id)
    if params[:task] == 'remove'
      UserCurricula.remove_contributor(@curricula, @contributor)
    else
      unless @contributor.blank?
        UserCurricula.create(user_id: @contributor.id, curricula_id:  @curricula.id)
      end
    end
    @contributors = UserCurricula.get_contributors @curricula
    respond_to do |format|
      format.js
    end
  end

  def search_results
    @users = User.where('lower(name) LIKE :query OR lower(email) LIKE :query OR lower(username) LIKE :query', query: "%#{params[:user]}%")
    respond_to do |format|
      format.js
    end
  end
end