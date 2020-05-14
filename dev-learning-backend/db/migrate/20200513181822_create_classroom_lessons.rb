class CreateClassroomLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :classroom_lessons do |t|
      t.integer :classroom_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
