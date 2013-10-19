class HomeController < ApplicationController
	def index
		
	end

	def dish_autocompleter
		dishautocomplete = Dish.search("#{params['search']}", autocomplete: true, limit:4).map(&:name)
		dishautocomplete.zip(Dish.search("#{params['search']}", partial: true).map(&:name)).flatten.compact! if dishautocomplete.size < 4
		respond_to do |format|
			format.json { render :json => {
				:dishes => { data: dishautocomplete[0..3] }
				}
			}
		end
	end

	def tag_autocompleter
		tagautocomplete = Tag.search("#{params['search']}", autocomplete:true, limit:4).map(&:name)
		tagautocomplete.zip(Tag.search("#{params['search']}", partial: true).map(&:name)).flatten.compact! if tagautocomplete.size < 4
		respond_to do |format|
			format.json { render :json => {
				:tags => {  data: tagautocomplete[0..3] }
				}
			}
		end
	end

	def place_autocompleter
		placeautocomplete = Location.search("#{params['search']}", autocomplete:true, limit:4).map(&:address)
		placeautocomplete.zip(Location.search("#{params['search']}", partial: true).map(&:address)).flatten.compact! if placeautocomplete.size < 4
		respond_to do |format|
			format.json { render :json => {
				:places => { data: placeautocomplete[0..3] }
				}
			}
		end
	end

	def trending_tags
		
	end

	def recently_added

	end

	def top_foodies
		
	end
end
