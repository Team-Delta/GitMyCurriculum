class UpdateCurriculumAndAddTables < ActiveRecord::Migration
  def change
    # adding columns for curriculas
    add_column    :curriculas, :path,         :string
    add_column    :curriculas, :created_at,   :datetime
    add_column    :curriculas, :updated_at,   :datetime
    add_column    :curriculas, :private_flag, :boolean, default: false, null: false
    add_column    :curriculas, :creator_id,   :integer
    add_column    :curriculas, :namespace_id, :integer
    add_column    :curriculas, :can_merge,    :boolean, default: true,  null: false
    remove_column :curriculas, :cur_private
    remove_column :curriculas, :owner

    # adding columns for user
    add_column :users, :can_create_team, :boolean, default: true, null: false
    add_column :users, :can_create_organization, :boolean, default: true, null: false

    create_table "curriculas_branches", force: true do |t|
        t.integer  "curriculas_id", null: false
        t.string   "name",          null: false
        t.datetime "created_at"
        t.datetime "updated_at"
    end

    create_table "change_requests", force: true do |t|
        t.string   "target_branch",                   null: false
        t.string   "source_branch",                   null: false
        t.integer  "curriculas_id",                   null: false
        t.integer  "author_id",                       null: false
        t.integer  "assigned_id"
        t.string   "title"
        t.boolean  "closed",          default: false, null: false
        t.datetime "created_at"
        t.datetime "updated_at"
        t.boolean  "change_accepted", default: false, null: false
        t.integer  "state",           default: 1,     null: false
        t.integer  "milestone_id"
        t.string   "change_status"
        t.text     "description"
    end

    create_table "milestones", force: true do |t|
        t.string   "title",                          null: false
        t.integer  "curriculas_id",                  null: false
        t.text     "description"
        t.date     "due_date"
        t.boolean  "closed",         default: false, null: false
        t.datetime "created_at"
        t.datetime "updated_at"
    end

    create_table "notifications", force: true do |t|
        t.string   "notification_type"
        t.integer  "target_id"
        t.string   "title"
        t.text     "data"
        t.integer  "curriculas_id"
        t.integer  "action"
        t.integer  "author_id"
        t.datetime "created_at"
        t.datetime "updated_at"
    end

    create_table "namespace", force: true do |t|
        t.string   "name",                     null: false
        t.string   "path",                     null: false
        t.integer  "owner_id"
        t.string   "type"
        t.string   "description", default: "", null: false
        t.datetime "created_at"
        t.datetime "updated_at"
    end

  end
end
