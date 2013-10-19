class Rate < ActiveRecord::Base
	belongs_to :rater, :class_name => "User"
	belongs_to :rateable, :polymorphic => true

	attr_accessible :rate, :dimension
	after_create :set_user_rating

	private
		def set_user_rating
			self.rater.increment(:no_of_ratings).save
		end
end