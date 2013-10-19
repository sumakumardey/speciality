class TagDish < ActiveRecord::Base
  searchkick
  attr_accessible :dish_id, :tag_id
  belongs_to :dish
  belongs_to :tag
  # scope :search_import,includes([:tag,:dish])
  # def search_data
  # 	{
  # 		tag: tag.name
  # 	}
  # end
end
