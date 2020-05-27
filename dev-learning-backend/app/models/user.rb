class User < ApplicationRecord
    has_secure_password

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users

    has_many :classrooms

    has_many :student_classrooms
    has_many :classrooms, through: :student_classrooms

    has_many :student_lessons
    has_many :lessons, through: :student_lessons

    has_many :completes
    has_many :lessons, through: :completes

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :role, presence: true
end
