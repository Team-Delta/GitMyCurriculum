class CreateWatching < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
        t.integer :user_id
        t.integer :peer_id
    end
  end
end
