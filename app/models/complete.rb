class Complete < ApplicationRecord
    belongs_to :user, foreign_key: :student_id
    belongs_to :lesson
end
