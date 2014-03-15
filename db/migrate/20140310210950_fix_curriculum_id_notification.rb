class FixCurriculumIdNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :curriculum_id
    add_column :notifications, :curricula_id, :integer
  end
end
