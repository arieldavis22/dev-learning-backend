class RemoveStudentFromClassrooms < ActiveRecord::Migration[6.0]
  def change
    remove_column :classrooms, :student_id
  end
end
