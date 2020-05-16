class CreateStudentClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :student_classrooms do |t|
      t.integer :classroom_id
      t.integer :student_id

      t.timestamps
    end
  end
end
