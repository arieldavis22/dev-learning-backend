class Lesson < ApplicationRecord
    has_many :classroom_lessons
    has_many :classrooms, through: :classroom_lessons

    has_many :student_lessons
    has_many :students, through: :student_lessons
end
