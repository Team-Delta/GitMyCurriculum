# create_table 'users', force: true do |t|
#   t.string   'email',                   default: '',   null: false
#   t.string   'encrypted_password',      default: '',   null: false
#   t.string   'reset_password_token'
#   t.datetime 'reset_password_sent_at'
#   t.datetime 'remember_created_at'
#   t.integer  'sign_in_count',           default: 0,    null: false
#   t.datetime 'current_sign_in_at'
#   t.datetime 'last_sign_in_at'
#   t.string   'current_sign_in_ip'
#   t.string   'last_sign_in_ip'
#   t.datetime 'created_at'
#   t.datetime 'updated_at'
#   t.string   'username'
#   t.text     'description'
#   t.string   'occupation'
#   t.string   'name'
#   t.boolean  'can_create_team',         default: true, null: false
#   t.boolean  'can_create_organization', default: true, null: false
# end
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  # relationships
  has_many :curriculas,                     through: :users_curriculas
  has_many :created_curriculas,             foreign_key: :creator_id, class_name: 'Curricula'
  has_many :users_curriculas,               dependent: :destroy
  has_many :notifications,                  dependent: :destroy, foreign_key: :author_id

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  validates :username,
            uniqueness: {
              case_sensitive: false
            }

  searchable do
    text :username, :name
  end
end
