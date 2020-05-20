class RemoveStudentLesson < ActiveRecord::Migration[6.0]
  def change
    drop_table :student_lessons
  end
end
