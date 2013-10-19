class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :user_id
      t.integer :location_id
      t.text :description
      t.integer :restaurant_id
      t.integer :avg_points
      t.integer :no_of_ratings

      t.timestamps
    end
  end
end
