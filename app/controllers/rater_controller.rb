class RaterController < ApplicationController 

	def create
		if current_or_guest_user.present?
			obj = eval "#{params[:klass]}.find(#{params[:id]})"
			if params[:dimension].present?
				obj.rate params[:score].to_i, current_or_guest_user.id, "#{params[:dimension]}"
			else
				obj.rate params[:score].to_i, current_or_guest_user.id 
			end
			render :json => { avg: obj.awesomeness_average.avg, qty: obj.awesomeness_average.qty }
		else
			render :json => false
		end
	end

end