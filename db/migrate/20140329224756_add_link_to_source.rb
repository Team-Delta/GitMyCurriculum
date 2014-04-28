class AddLinkToSource < ActiveRecord::Migration
  def change
    add_column :sources, :link, :text
  end
end
