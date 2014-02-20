class CreateUsersCurricula < ActiveRecord::Migration
  def change
    create_table :users_curriculas do |t|
        t.integer  'user_id',                                      null: false
        t.integer  'curricula_id',                                 null: false
        t.integer  'curricula_permission_level',     default: 0,   null: false
        t.datetime 'created_at',                                   null: false
        t.datetime 'updated_at',                                   null: false
    end
  end
end
