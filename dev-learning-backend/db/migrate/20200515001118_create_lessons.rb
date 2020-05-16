class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :points
      t.integer :teacher_id
      t.string :deadline
      t.text :return_value
      t.text :description
      t.text :boilerplate

      t.timestamps
    end
  end
end
