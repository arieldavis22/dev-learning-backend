class ClassroomLesson < ApplicationRecord
    belongs_to :lesson
    belongs_to :classroom
end
