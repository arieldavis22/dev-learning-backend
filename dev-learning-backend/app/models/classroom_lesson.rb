class ClassroomLesson < ApplicationRecord
    belongs_to :classroom
    belongs_to :lesson
end
