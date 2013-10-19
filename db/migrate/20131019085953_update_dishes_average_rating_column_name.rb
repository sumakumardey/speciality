class UpdateDishesAverageRatingColumnName < ActiveRecord::Migration
  def up
    rename_column :dishes, :avg_points, :avg_ratings
    change_column :dishes, :avg_ratings, :float
  end

  def down
    rename_column :dishes, :avg_ratings, :avg_points
    change_column :dishes, :avg_points, :integer
  end
end
