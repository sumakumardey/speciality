class TagsController < ApplicationController
	def search
		tags = Tag.search params[cname][:name], autocomplete: true
		respond_to do |format|
			format.json {
				results = tags.map{ |tag| { :id => tag.name, :text => tag.name } }
				render json: results
			}
		end
	end

	private
		def cname
			@cname ||= controller_path.gsub('/', '_').singularize
		end
end
