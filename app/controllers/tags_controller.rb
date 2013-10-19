class TagsController < ApplicationController
	def search
		tags = Tag.search params[cname][:name]
		respond_to do |format|
			# format.html { redirect_to tags_url }
			format.json { render json: tags.map(&:name) }
		end
	end

	private
		def cname
			@cname ||= controller_path.gsub('/', '_').singularize
		end
end
