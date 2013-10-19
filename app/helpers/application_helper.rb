module ApplicationHelper

  def rating_stars(dish)
    content_tag :div do
      rating_for dish, "awesomeness"
    end
  end

  def rating_average(dish)
    content_tag :div, :class => "ratings_average"  do
      "#{dish.avg_ratings.to_i} / 5"
    end
  end

  def awesomeness_qty(dish)
    content_tag :span, :class => "no_of_people_rated" do
      "#{dish.no_of_ratings.to_i}"
    end
  end

end
