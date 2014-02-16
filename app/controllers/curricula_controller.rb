class CurriculaController < ApplicationController
	#where to put the user to auto assign the creater/owner
	def load

	end

	def create
		if request.post?
			@info = Curricula.new(post_params)
			@info.save
			redirect_to "/dashboard/dashboard_main"
		end
	end

	def edit
		@info = Curricula.all
	end

	private

	def post_params
		params.permit(:cur_name, :cur_description)
	end

end
