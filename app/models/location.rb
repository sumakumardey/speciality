class Location < ActiveRecord::Base
  searchkick autocomplete: ['address']
  attr_accessible :city, :country, :latitude, :longitude, :state, :street, :address
  has_many :users
  has_many :restaurants
  has_many :dishes
end
