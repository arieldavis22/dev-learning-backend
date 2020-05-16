class Classroom < ApplicationRecord
    belongs_to :user, foreign_key: :teacher_id

    has_many :student_classrooms
    has_many :users, foreign_key: :student_id, through: :student_classrooms

    has_many :classroom_lessons
    has_many :lessons, through: :classroom_lessons

    validates :teacher_id, teacher_classroom: true

end
