class StudentClassroom < ApplicationRecord
    belongs_to :user, foreign_key: :student_id
    belongs_to :classroom, foreign_key: :classroom_id

    validates :student_id, student_classroom: true
end
