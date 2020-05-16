class StudentClassroomValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        user = User.find_by(id: value)

        if user.role != "Student"
            record.errors[attribute] << ("is not a student")
        end
    end
end