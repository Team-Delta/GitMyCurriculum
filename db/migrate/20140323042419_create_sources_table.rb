class CreateSourcesTable < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      #curriculm has many sources
      #users can add sources by being a part of curriculum
      t.integer "curricula_id", null: false
      t.integer "creator_id", null: false
      t.string "author"
      t.string "title"
      t.string "source_tag"
      t.datetime "created_at", null: false 
      t.datetime "updated_at", null: false 
      t.datetime "written_at"
    end
  end
end