class Curricula < ActiveRecord::Base

    belongs_to :creator,      foreign_key: "creator_id", class_name: "User"

    has_many :users_projects, dependent: :destroy
    has_many :users, through: :users_projects

    validates :creator, presence: true, on: :create
    validates :cur_description, length: { maximum: 2000 }, allow_blank: true

	searchable do
		text :cur_name
	end

end
