class ChangeCommentMessageTrue < ActiveRecord::Migration
  def change
    change_column :comments, :message, :text, null: true
  end
end
