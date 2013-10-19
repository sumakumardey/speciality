class Review < ActiveRecord::Base
  attr_accessible :description, :dish_id, :user_id
end
