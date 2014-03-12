# create_table "notifications", force: true do |t|
#   t.text     "message"
#   t.datetime "created_at",    null: false
#   t.datetime "updated_at",    null: false
#   t.integer  "author_id"
#   t.integer  "curricula_id"
#   t.integer  "notification_type"
#   t.integer  "commit_id"
# end

# Notifications for users when something changes in a curriculum they are participating in
class Notification < ActiveRecord::Base
  # Notification Types
  N_SAVE = 0             # equiv to add commit push
  N_REQUEST = 1          # equiv to merge request
  N_JOIN = 2             # equiv to merge
  N_FORK = 3             # forking a repo
  N_COMMENT = 4          # comment on repo
  N_REQUEST_APPROVE = 5  # if a request gets approved
  N_REQUEST_DENY = 6     # if a request gets denied

  belongs_to :curricula
  belongs_to :author, class_name: 'User'

  class << self
  end
end