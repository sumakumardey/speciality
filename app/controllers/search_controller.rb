class SearchController < ApplicationController
	before_filter :load_recent_dishes, :compute_trending_tags
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
		@dishes = search_with_min_cost_and_max_cost unless @data.blank?
		unless @dishes.blank?
			sort_result
		end
		respond_to do |format|
			format.js {  }
			format.html {  }
			# render json: @data
		end
	end

	private

	def search_with_tags
		@onload_tags = params[:search][:tags]
		Dish.search("#{params[:search][:tags]}", fields:[:tag],partial:true).collect(&:id)
	end

	def search_with_location
		@onload_location = params[:search][:location]
		Dish.search("#{params[:search][:location]}", fields:[:location],partial:true).collect(&:id)
	end

	def search_with_name
		Dish.search("#{params[:search][:name]}", fields:[:name],partial:true).collect(&:id)
	end

	def search_with_min_cost_and_max_cost
		if params[:search][:min_cost].present? && params[:search][:max_cost].present?
			Dish.find(:all, :conditions => ["id in (?) and cost >= ? and cost <= ?",@data,params[:search][:min_cost],params[:search][:max_cost]])	
		else
			Dish.find_all_by_id(@data)
		end
	end
	
	def load_recent_dishes
		@recent_dishes = Dish.find_recent_dishes(20).include_tags
	end
	
	def compute_trending_tags
		@tags = @recent_dishes.map(&:tags).reject(&:blank?).flatten.uniq
		list = @tags.map { |tag| [tag, @recent_dishes.select{ |dish| dish.tags.include? tag }.sum(&:total_ratings)] }
		@trending_tags_array = list.sort_by(&:last).reverse[0..11]
	end
	
	def sort_result
		allowed_sort = [:cost, :total_ratings, :location]
		sort_attribute = (params[:search] || {})[:sort]
		if sort_attribute.present? && allowed_sort.include?(sort_attribute.to_sym)
			@dishes.sort!{|a,b| b.send(sort_attribute) <=> a.send(sort_attribute) }
		end
	end

end