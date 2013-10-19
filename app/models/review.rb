class Review < ActiveRecord::Base
  attr_accessible :description, :dish_id, :user_id
  belongs_to :dish
  belongs_to :user
end
