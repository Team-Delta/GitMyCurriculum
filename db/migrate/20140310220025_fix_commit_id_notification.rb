class FixCommitIdNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :commit_id
    add_column :notifications, :commit_id, :string
  end
end
