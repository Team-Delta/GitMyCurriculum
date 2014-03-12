class FixType < ActiveRecord::Migration
  def change
    remove_column :notifications, :type
    add_column :notifications, :notification_type, :integer
  end
end
