class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :lesson_id
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
