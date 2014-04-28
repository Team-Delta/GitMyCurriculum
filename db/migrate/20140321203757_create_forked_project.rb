class CreateForkedProject < ActiveRecord::Migration
  def change
    create_table :forked_curriculas do |t|
      t.integer 'forked_to_curriculum_id', null: false
      t.integer 'forked_from_curriculum_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  end
end
