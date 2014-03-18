class CreateFollowingCurriculasTable < ActiveRecord::Migration
  def change
    create_table :following_curriculas do |t|
      t.belongs_to :user
      t.belongs_to :curricula
    end
  end
end
