class Location < ActiveRecord::Base
  attr_accessible :city, :country, :latitude, :longitude, :state, :street
  has_many :users
  has_many :restaurents
  has_many :dishes
end
