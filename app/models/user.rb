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
        if login = conditions.delete(:login)
            where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        else
            where(conditions).first
        end
    end

    validates :username,
        :uniqueness => {
            :case_sensitive => false
        }

    searchable do
        text :username, :name
    end
end
