class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_guest_user

  def current_user?
    !current_user
  end
  helper_method :current_user?

  def set_guest_user
    if current_user?
      guest_user
    end
  end

  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end
  helper_method :current_or_guest_user

  def guest_user
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user
  end

  private

  def logging_in

    # belongs_to :location
    if guest_user.location
      current_user.location = location
      current_user.save!
    end

    #has_many :dishes
    guest_dishes = guest_user.dishes.all
    guest_dishes.each do |dish|
      dish.user_id = current_user.id
      dish.save!
    end

    #has_many :reviews
    guest_reviews = guest_user.reviews.all
    guest_reviews.each do |review|
      review.user_id = current_user.id
      review.save!
    end

    #has_many :ratings
    guest_ratings = guest_user.ratings_given.all
    guest_ratings.each do |rating|
      rating.rater_id = current_user.id
      rating.save!
    end

    #has_one :attachment
    attachment = guest_user.attachment
    if attachment
      attachment.attachable_id = current_user.id
      attachment.save!
    end
  end

  def create_guest_user
    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end
