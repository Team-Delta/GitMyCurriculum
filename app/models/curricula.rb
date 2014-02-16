class Curricula < ActiveRecord::Base

	has_many :users

	searchable do
		text :cur_name
	end

end
