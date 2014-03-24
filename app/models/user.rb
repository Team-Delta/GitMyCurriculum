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
  has_many :notifications, dependent: :destroy, foreign_key: :author_id, class_name: 'Notification'
  has_many :user_curriculas
  has_many :curriculas, through: :user_curriculas

  has_many :watching
  has_many :peers, through: :watching

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
    text :username,  stored: 'true'
    text :name,  stored: 'true'
  end

  class << self
    def find_user_by_email(email)
      find_by('users.email = ?', email)
    end

    def find_user_by_username(username)
      where('users.username = ?', username).first
    end
  end
end
