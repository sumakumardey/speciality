class Dish < ActiveRecord::Base
	searchkick autocomplete: ['name']
	attr_accessible :avg_points, :description, :location_id, :name, :no_of_ratings, :restaurant_id, :user_id
	belongs_to :user
	belongs_to :location
	belongs_to :restaurant
	has_many :reviews
	has_many :tag_dishes
	has_many :tags, :through => :tag_dishes
	has_many :searches

	scope :search_import,includes([:tag_dishes,:tags])
	def search_data
		{
			tag: tags.collect(&:name)
		}
	end

	attr_accessor :tag_names, :restaurant_name
	before_save :build_new_tags
	validates :restaurant_id, :presence => :true

	private
		def build_new_tags
			(tag_names || []).each do |name|
				self.tags << Tag.find_or_create_by_name(name)
			end
		end
end
