class AddLanguageToLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :language, :integer
  end
end
