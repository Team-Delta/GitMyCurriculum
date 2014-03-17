# class CreateWatching < ActiveRecord::Migration
#  def change
#    create_table :watchings do |t|
#        t.integer :user_id
#        t.integer :peer_id
#    end
#  end
# end
class Watching < ActiveRecord::Base
  belongs_to :user
  belongs_to :peer, class_name: 'User'

  class << self

    def create_follow_relationship_for(user, peer)
      create(user_id: user.id, peer_id: peer.id)
    end

    def delete_follow_relationship_for(user, peer)
      where('user_id = ? AND peer_id = ?', user, peer).destroy_all
    end

    def find_peers_for(user, peer)
      where('user_id=? AND peer_id=?', user, peer) 
    end
  end
end
