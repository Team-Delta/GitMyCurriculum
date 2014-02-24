class UserCurricula < ActiveRecord::Base
  belongs_to :user
  belongs_to :curricula
end