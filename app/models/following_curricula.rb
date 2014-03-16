# Join table to keep track of curricula user follows
class FollowingCurricula < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :curricula,  class_name: 'Curricula'
end
