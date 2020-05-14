class Follow < ApplicationRecord
    belongs_to :follower, class_name: "Teacher"
    belongs_to :followee, class_name: "Teacher"
end
