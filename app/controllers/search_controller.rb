class SearchController < ApplicationController
  before_filter :search_with_tags, :search_with_location
  def index
    filter = [:tags,:location,:name]
    @data = []
    flag = false
    params[:search].each_pair do |search_filter, search_value|
      next unless filter.include?(search_filter)
      if flag && search_value.present?
        @data = @data & self.send("search_with_#{search_filter}")
      else
        @data = self.send("search_with_#{search_filter}")
        flag = true
      end

    end
    @data
  end

  private

  def search_with_tags
    @all_dishes_with_tags = []
    return if params[:search][:tags]
    @all_dishes_with_tags = Dish.search("#{params[:search][:tags]}", fields:[:tag],partial:true).collect(&:id)
  end

  def search_with_location
    @all_dishes_with_location = []
    return if params[:search][:location]
    @all_dishes_with_location = Dish.search("#{params[:search][:location]}", fields:[:location],partial:true).collect(&:id)
  end

  def search_with_name
    @all_dishes_with_name = []
    return if params[:search][:name]
    @all_dishes_with_location = Dish.search("#{params[:search][:name]}", fields:[:name],partial:true).collect(&:id)
  end

end