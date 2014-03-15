class AddCommitIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :commit_id, :integer
  end
end
