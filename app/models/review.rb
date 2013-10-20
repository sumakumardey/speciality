class Review < ActiveRecord::Base
  attr_accessible :description, :dish_id, :user_id
  attr_accessor :score

  belongs_to :dish
  belongs_to :user

	after_create :set_user_reviews
  after_create :set_dish_rating

  validates :score, :presence => :true, :on => :create
  validates :description, :presence => :true

	private
		def set_user_reviews
			self.user.increment(:no_of_reviews).save
		end

    def set_dish_rating
      self.dish.rate(score, user_id, "awesomeness")
    end
end
