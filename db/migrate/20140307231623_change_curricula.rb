class ChangeCurricula < ActiveRecord::Migration
  def change
    remove_column :notifications, :type
    add_column    :notifications, :author_id,      :integer
    add_column    :notifications, :curriculum_id,  :integer
    add_column    :notifications, :type,           :integer
  end
end
