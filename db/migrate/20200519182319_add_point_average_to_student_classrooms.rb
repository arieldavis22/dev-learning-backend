class AddPointAverageToStudentClassrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :student_classrooms, :point_average, :integer
  end
end
