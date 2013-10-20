class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :omniauthable,
	:omniauth_providers => [:twitter, :facebook]

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me
	attr_accessible :facebook_id, :location_id, :name, :no_of_ratings, :no_of_reviews, :twitter_id
  attr_accessible :profile_image
	attr_accessible :provider, :uid

	belongs_to :location
	has_many :dishes, :dependent => :destroy
	has_many :reviews, :dependent => :destroy
  has_one :attachment, :as => :attachable, :dependent => :destroy
	letsrate_rater

  scope :find_recent_users, lambda { |count|
    order("created_at DESC").limit(count)
  }

  def calculate_score
    sum = 0

    if(no_of_ratings)
      sum += (no_of_ratings * 3) 
    end

    if(no_of_reviews)
      sum += (no_of_reviews * 10)
    end

    (sum + self.dishes.sum(&:total_ratings)).to_i
  end

	def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		unless user
			user = User.create(name:  auth.extra.raw_info.name,
			provider:  auth.provider,
			uid: auth.uid,
			email: auth.info.email,
			twitter_id: auth.info.nickname,
      profile_image: auth.info.image
      )
		end
		user
	end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         facebook_id: auth.info.nickname,
                         profile_image: auth.info.image
                        )
    end
    user
  end

	def email_required?
		false
	end
	
end
