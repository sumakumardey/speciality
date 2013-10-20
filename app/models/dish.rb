class Dish < ActiveRecord::Base
	searchkick autocomplete: ['name']
	attr_accessible :avg_ratings, :description, :location_id, :name,
			:no_of_ratings, :restaurant_id, :user_id, :tag_names, :restaurant_name, :attachment
	attr_accessor :tag_names, :restaurant_name, :score
	belongs_to :user
	belongs_to :location
	belongs_to :restaurant
	has_many :reviews
	has_many :tag_dishes
	has_many :tags, :through => :tag_dishes
	has_many :searches
	delegate :name, :to => :restaurant, :allow_nil => true, :prefix => true
	delegate :address, :to => :location, :allow_nil => true, :prefix => true
  letsrate_rateable "awesomeness"

  has_one :attachment, :as => :attachable, :dependent => :destroy


	scope :search_import,includes([:tag_dishes,:tags])
	scope :find_recent_dishes, lambda { |items|
		order("created_at DESC").limit(items)
	}

  after_create :add_dish_rating

	scope :include_tags, includes([:tags, :restaurant])

	def search_data
		{
			tag: tags.collect(&:name),
			name: name,
			location: location.address
		}
	end

	def total_ratings
		avg_ratings.present? && no_of_ratings.present? ? avg_ratings * no_of_ratings : 0
	end

	before_save :build_new_tags
	validates :restaurant_id, :presence => :true
	validates :name, :presence => :true
  validates :score, :presence => :true, :on => :create

	def self.recently_added
		Dish.find(:all, :include => :location, :order => "id desc", :limit => 8)
	end

	def self.search_all_with_id(ids)
		Dish.find(:all,:conditions => { :id => ids } , :include => :location, :order => "id desc", :limit => 8)
	end

	private
		def build_new_tags
			return if tag_names.blank?
			self.tags.clear
			(tag_names || "").split(",").each do |name|
				tag = Tag.find_or_create_by_name(name)
				self.tags << tag
			end
		end

    def add_dish_rating
      rate(score, user_id, "awesomeness") 
    end

end
