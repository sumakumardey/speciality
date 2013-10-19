class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :tag_dishes
  has_many :dishes, :through => :tag_dishes
end
