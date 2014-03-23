class AddStreamToNotificaiton < ActiveRecord::Migration
  def change
    add_column :notifications, :stream, :string
  end
end
