# Join table for users and curricula many-to-many relationship
class UserCurricula < ActiveRecord::Base
  belongs_to :user
  belongs_to :curricula
end
