class Review < ActiveRecord::Base
  attr_accessible :description, :dish_id, :user_id
  belongs_to :dish
  belongs_to :user

	after_create :set_user_reviews

	private
		def set_user_reviews
			self.user.increment(:no_of_reviews).save
		end
end
