class RestaurantsController < ApplicationController
	def search
		restaurants = Restaurant.search params[cname][:name], autocomplete: true
		respond_to do |format|
			results = restaurants.map{ |restaurant| { :id => restaurant.name, :text => restaurant.name } }
			format.json { render json: results }
		end
	end

	private
		def cname
			@cname ||= controller_path.gsub('/', '_').singularize
		end
end
