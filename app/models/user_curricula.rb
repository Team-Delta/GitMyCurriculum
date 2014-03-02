# Join table for users and curricula many-to-many relationship
class UserCurricula < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :curricula,  class_name: 'Curricula'
end
