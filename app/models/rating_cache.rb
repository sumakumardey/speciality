class RatingCache < ActiveRecord::Base
  belongs_to :cacheable, :polymorphic => true 
  after_save :set_dish_rating
  attr_accessible :cacheable_id, :cacheable_type, :dimension

  private

    def set_dish_rating
      cacheable.update_attributes(:avg_ratings => avg, :no_of_ratings => qty)
    end
end
