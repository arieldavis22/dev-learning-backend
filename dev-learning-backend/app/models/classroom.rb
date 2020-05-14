class Classroom < ApplicationRecord
    belongs_to :teacher
    belongs_to :student

    has_many :classroom_lessons
    has_many :lessons, through: :classroom_lessons
end
