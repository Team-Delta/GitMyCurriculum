class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :occupation, :string
  end
end
