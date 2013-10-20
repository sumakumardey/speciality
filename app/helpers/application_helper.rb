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

  def flash_display
    response = ""
    flash.each do |name, msg|
      response = response + 
        content_tag(:div, msg, :id => "flash_#{name}")
    end
    flash.discard
    response
  end

  def foodie_profile_image(foodie, size, css)
    if foodie.twitter_id?
      twitter_profile_image(foodie, size, css)
    elsif foodie.facebook_id?
      facebook_profile_image(foodie, size, css)
    else
      image_tag(asset_path('default-profile-pic.png'), :class => css)
    end
  end

  def twitter_profile_image(foodie, size, css)
      if(size == "top_foodie")
        image_tag(foodie.profile_image.sub("_normal", ""),
                  :class => css)
      elsif(size == "review")
        image_tag(foodie.profile_image.sub("_normal", "_bigger"),
                  :class => css)
      end
  end

  def facebook_profile_image(foodie, size, css)
    if(size == "top_foodie")
      image_tag(foodie.profile_image.sub("square", "large"), 
                :class => css)
    elsif(size == "review")
      image_tag(foodie.profile_image.sub("square", "large"),
                                         :class => css)
    end
  end

end
