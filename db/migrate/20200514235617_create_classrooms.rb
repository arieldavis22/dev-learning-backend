class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.integer :teacher_id
      t.integer :student_id
      t.string :name

      t.timestamps
    end
  end
end
