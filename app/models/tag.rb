class Tag < ActiveRecord::Base
	searchkick
  attr_accessible :name
  has_many :tag_dishes
  has_many :dishes, :through => :tag_dishes
end
