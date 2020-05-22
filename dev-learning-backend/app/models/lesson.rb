class Lesson < ApplicationRecord
    has_many :classroom_lessons
    has_many :classrooms, through: :classroom_lessons

    has_many :student_lessons
    has_many :users, foreign_key: :student_id, through: :student_lessons

    has_many :reports

    validates :teacher_id, teacher_classroom: true

end
