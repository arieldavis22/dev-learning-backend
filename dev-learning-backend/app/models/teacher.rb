class Teacher < ApplicationRecord
    has_secure_password
    has_many :classrooms
    has_many :students, through: :classrooms

    has_many :followed_users, foreign_key: :follower_id, class_name: "Follow"
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
end
