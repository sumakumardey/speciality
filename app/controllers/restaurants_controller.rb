class RestaurantsController < ApplicationController
	def search
		restaurants = Restaurant.search params[cname][:name], autocomplete: true
		respond_to do |format|
			format.json { render json: restaurants.map(&:name) }
		end
	end

	private
		def cname
			@cname ||= controller_path.gsub('/', '_').singularize
		end
end
