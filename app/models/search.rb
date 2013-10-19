class Search < ActiveRecord::Base
  attr_accessible :query
  belongs_to :item
end
