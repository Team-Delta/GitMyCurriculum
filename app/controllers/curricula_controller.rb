class CurriculaController < ApplicationController
	#where to put the user to auto assign the creater/owner
	def load

	end

	def create
		if request.post?
			@curricula = Curricula.new(curricula_params)
			@curricula.save
			redirect_to dashboard_dashboard_main_path
		end
	end

	def edit
		@curricula = Curricula.find(params[:id])
		@curricula.update_attributes(curricula_params)
		redirect_to dashboard_dashboard_main_path
	end

	private

	def curricula_params
		params.require(:curricula).permit(:cur_name, :cur_description)
	end

end
