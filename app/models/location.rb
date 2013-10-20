class Location < ActiveRecord::Base
  searchkick autocomplete: ['address']
  attr_accessible :city, :country, :latitude, :longitude, :state, :street, :address
  has_many :users
  has_many :restaurants
  has_many :dishes
  before_save :set_default_location

  def set_default_location
  	if !(self.latitude && self.longitude)
  		self.latitude = 37.7833
  		self.longitude = -122.4167
  		self.address = self.address.blank? ? "San Francisco, CA" : self.address
  	end 
  end
end
