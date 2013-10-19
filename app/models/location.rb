class Location < ActiveRecord::Base
  attr_accessible :city, :country, :latitude, :longitude, :state, :street
end
