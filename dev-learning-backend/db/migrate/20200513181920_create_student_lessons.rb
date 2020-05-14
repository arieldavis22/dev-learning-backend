class CreateStudentLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :student_lessons do |t|
      t.integer :student_id
      t.integer :lesson_id
      t.integer :grade

      t.timestamps
    end
  end
end
