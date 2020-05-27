class CreateCompletes < ActiveRecord::Migration[6.0]
  def change
    create_table :completes do |t|
      t.integer :lesson_id
      t.integer :student_id
      t.boolean :done

      t.timestamps
    end
  end
end
