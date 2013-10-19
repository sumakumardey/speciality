class Dish < ActiveRecord::Base
  attr_accessible :avg_points, :description, :location_id, :name, :no_of_ratings, :restaurant_id, :user_id
  belongs_to :user
  belongs_to :location
  belongs_to :restaurant
  has_many :reviews
  has_many :tag_dishes
  has_many :tags, :through => :tag_dishes
end
