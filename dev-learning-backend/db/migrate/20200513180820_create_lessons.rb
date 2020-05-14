class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :points
      t.string :deadline
      t.string :return_value
      t.text :description
      t.text :boiler_plate
      t.integer :teacher_id

      t.timestamps
    end
  end
end
