class Dish < ActiveRecord::Base
  attr_accessible :avg_points, :description, :location_id, :name, :no_of_ratings, :restaurant_id, :user_id
end
