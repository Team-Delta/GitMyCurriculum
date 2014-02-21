# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_140_219_010_514) do

  create_table 'change_requests', force: true do |t|
    t.string   'target_branch',                   null: false
    t.string   'source_branch',                   null: false
    t.integer  'curriculas_id',                   null: false
    t.integer  'author_id',                       null: false
    t.integer  'assigned_id'
    t.string   'title'
    t.boolean  'closed',          default: false, null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.boolean  'change_accepted', default: false, null: false
    t.integer  'state',           default: 1,     null: false
    t.integer  'milestone_id'
    t.string   'change_status'
    t.text     'description'
  end

  create_table 'curriculas', force: true do |t|
    t.string   'cur_name',        default: '*subject to change*', null: false
    t.text     'cur_description'
    t.string   'path'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.boolean  'private_flag',    default: false,                 null: false
    t.integer  'creator_id'
    t.integer  'namespace_id'
    t.boolean  'can_merge',       default: true,                  null: false
  end

  create_table 'curriculas_branches', force: true do |t|
    t.integer  'curriculas_id', null: false
    t.string   'name',          null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'milestones', force: true do |t|
    t.string   'title',                         null: false
    t.integer  'curriculas_id',                 null: false
    t.text     'description'
    t.date     'due_date'
    t.boolean  'closed',        default: false, null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'namespace', force: true do |t|
    t.string   'name',                     null: false
    t.string   'path',                     null: false
    t.integer  'owner_id'
    t.string   'type'
    t.string   'description', default: '', null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'notifications', force: true do |t|
    t.string   'notification_type'
    t.integer  'target_id'
    t.string   'title'
    t.text     'data'
    t.integer  'curriculas_id'
    t.integer  'action'
    t.integer  'author_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'users', force: true do |t|
    t.string   'email',                   default: '',   null: false
    t.string   'encrypted_password',      default: '',   null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count',           default: 0,    null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string   'current_sign_in_ip'
    t.string   'last_sign_in_ip'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string   'username'
    t.text     'description'
    t.string   'occupation'
    t.string   'name'
    t.boolean  'can_create_team',         default: true, null: false
    t.boolean  'can_create_organization', default: true, null: false
  end

  add_index 'users', ['email'], name: 'index_users_on_email', unique: true, using: :btree
  add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  add_index 'users', ['username'], name: 'index_users_on_username', unique: true, using: :btree

  create_table 'users_curriculas', force: true do |t|
    t.integer  'user_id',                                null: false
    t.integer  'curricula_id',                           null: false
    t.integer  'curricula_permission_level', default: 0, null: false
    t.datetime 'created_at',                             null: false
    t.datetime 'updated_at',                             null: false
  end

end
