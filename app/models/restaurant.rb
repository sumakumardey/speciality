class Restaurant < ActiveRecord::Base
	searchkick autocomplete: ['name']
  attr_accessible :location_id, :name
  belongs_to :location
  has_many :dishes
  validates :name, :presence => :true
end
