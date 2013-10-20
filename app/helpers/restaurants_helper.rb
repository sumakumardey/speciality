module RestaurantsHelper
  def res_ratings(res)
    dish_review_ids = Dish.find_all_by_restaurant_id(res.id, :select => 'id').map(&:id)
    Rate.find(:all, :conditions => ["rateable_id IN (?)", dish_review_ids]).count
  end

  def res_review(res)
    dish_review_ids = Dish.find_all_by_restaurant_id(res.id, :select => 'id').map(&:id)
    Review.find(:all, :conditions => ["dish_id IN (?)", dish_review_ids]).count
  end

end
