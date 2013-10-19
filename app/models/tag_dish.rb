class TagDish < ActiveRecord::Base
  attr_accessible :dish_id, :tag_id
  belongs_to :dish
  belongs_to :tag
end
