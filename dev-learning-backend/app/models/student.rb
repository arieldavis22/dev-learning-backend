class Student < ApplicationRecord
    has_secure_password
    has_many :classrooms
    has_many :teachers, through: :classrooms

    has_many :student_lessons
    has_many :lessons, through: :student_lessons

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
end
