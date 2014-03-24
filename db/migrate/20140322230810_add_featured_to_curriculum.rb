class AddFeaturedToCurriculum < ActiveRecord::Migration
  def change
    add_column :curriculas, :featured, :boolean, default: false, null: false
  end
end
