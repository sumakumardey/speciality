module ApplicationHelper
  def current_user?
    !current_user
  end

  def rating_stars(dish)
    content_tag :div do
      rating_for dish, "awesomeness"
    end
  end

  def rating_average(dish)
    content_tag :div, :class => "average"  do
      "#{dish.awesomeness_average.avg} / 5"
    end
  end

  def awesomeness_qty(dish)
    content_tag :div do
      "No of people who rated : #{dish.awesomeness_average.qty.to_s}"
    end
  end

end
