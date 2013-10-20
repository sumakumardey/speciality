class SearchController < ApplicationController
	# before_filter :search_with_tags, :search_with_location
	def index
		allowed_filters = [:tags,:location,:name]
		@data = []
		flag = false
		(params[:search] || {}).each_pair do |search_filter, search_value|
			next if !allowed_filters.include?(search_filter.to_sym) || search_value.blank?
			if flag 
				@data = @data & self.send("search_with_#{search_filter}")
			else
				@data = self.send("search_with_#{search_filter}")
				flag = true
			end
		end
		@dishes = Dish.find_all_by_id(@data) unless @data.blank?
		respond_to do |format|
			format.js {  }
			format.html {  }
			# render json: @data
		end
	end

	private

	def search_with_tags
		@tags = params[:search][:tags]
		Dish.search("#{params[:search][:tags]}", fields:[:tag],partial:true).collect(&:id)
	end

	def search_with_location
		Dish.search("#{params[:search][:location]}", fields:[:location],partial:true).collect(&:id)
	end

	def search_with_name
		Dish.search("#{params[:search][:name]}", fields:[:name],partial:true).collect(&:id)
	end

end