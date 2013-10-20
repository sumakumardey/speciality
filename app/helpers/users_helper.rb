module UsersHelper

  def user_review_rated_dishes(user)
    dish_rated_ids = Rate.find_all_by_rater_id(user.id, :select => 'rateable_id').map(&:rateable_id)
    dish_review_ids = Review.find_all_by_user_id(user.id, :select => 'dish_id').map(&:dish_id)

    dish_rated_ids = dish_rated_ids.concat(dish_review_ids)
    dish_rated_ids = dish_rated_ids.uniq

    Dish.find(:all, :conditions => ["id IN (?) ",dish_rated_ids])
  end
end
