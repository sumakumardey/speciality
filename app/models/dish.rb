class Dish < ActiveRecord::Base
	searchkick autocomplete: ['name']
	attr_accessible :avg_ratings, :description, :location_id, :name,
			:no_of_ratings, :restaurant_id, :user_id, :tag_names, :restaurant_name
	attr_accessor :tag_names, :restaurant_name
	belongs_to :user
	belongs_to :location
	belongs_to :restaurant
	has_many :reviews
	has_many :tag_dishes
	has_many :tags, :through => :tag_dishes
	has_many :searches
	delegate :name, :to => :restaurant, :allow_nil => true, :prefix => true
  letsrate_rateable "awesomeness"

	scope :search_import,includes([:tag_dishes,:tags])
	def search_data
		{
			tag: tags.collect(&:name),
			name: name
		}
	end

	before_save :build_new_tags
	validates :restaurant_id, :presence => :true
	validates :name, :presence => :true

	private
		def build_new_tags
			self.tags.clear
			(tag_names || "").split(",").each do |name|
				tag = Tag.find_or_create_by_name(name)
				self.tags << tag
			end
		end
end
