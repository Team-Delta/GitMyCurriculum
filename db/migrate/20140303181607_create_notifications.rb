class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      # curriculum has many notifications
      # users receive notifications by being apart of the curriculum
      t.text "message"
      t.string "type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
