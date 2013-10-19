class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable,
    :omniauth_providers => [:twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :facebook_id, :location_id, :name, :no_of_ratings, :no_of_reviews, :twitter_id
  attr_accessible :provider, :uid

  belongs_to :location
  has_many :items
  has_many :reviews

  letsrate_rater

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.new(name:  auth.extra.raw_info.name,
                         provider:  auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         twitter_id: auth.info.nickname)
      user.save
    end
    user
  end

  def email_required?
    false
  end
end
