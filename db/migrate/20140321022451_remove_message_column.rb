class RemoveMessageColumn < ActiveRecord::Migration
  def change
    remove_column :notifications, :message
  end
end
