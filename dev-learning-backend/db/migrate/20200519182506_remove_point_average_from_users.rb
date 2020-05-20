class RemovePointAverageFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :point_average, :integer
  end
end
