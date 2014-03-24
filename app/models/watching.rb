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
    # creates a uni directional join between users
    #
    # +user+:: user who is following their peer
    # +peer+:: user that is being followed
    def create_follow_relationship_for(user, peer)
      create(user_id: user.id, peer_id: peer.id)
    end

    # destroys the uni directional join between users
    #
    # +user+:: user object who is unfollowing their peer
    # +peer+:: user object that is being unfollowed
    def delete_follow_relationship_for(user, peer)
      where('user_id = ? AND peer_id = ?', user, peer).destroy_all
    end

    # find the a specific peer for a specific user
    #
    # +user+:: user object to start from
    # +peer+:: user object to search for
    def find_peers_for(user, peer)
      where('user_id=? AND peer_id=?', user, peer)
    end
  end
end
