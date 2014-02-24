class CreateUserCurriculasTable < ActiveRecord::Migration
  def change
    create_table :user_curriculas do |t|
      t.belongs_to :user
      t.belongs_to :curricula
    end
  end
end
