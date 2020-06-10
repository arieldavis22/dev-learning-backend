class TeacherClassroomValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        user = User.find_by(id: value)

        if user.role != "Teacher"
            record.errors[attribute] << ("is not a teacher")
        end
    end
end