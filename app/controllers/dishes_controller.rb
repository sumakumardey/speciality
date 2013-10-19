class DishesController < ApplicationController
	before_filter :load_restaurant, :only => [:create, :update]
	# GET /dishes
	# GET /dishes.json
	def index
		@dishes = Dish.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @dishes }
		end
	end

	# GET /dishes/1
	# GET /dishes/1.json
	def show
		@dish = Dish.find(params[:id])
    @reviews = @dish.reviews.all
    @new_review = @dish.reviews.new

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @dish }
		end
	end

	# GET /dishes/new
	# GET /dishes/new.json
	def new
		@dish = current_or_guest_user.dishes.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @dish }
		end
	end

	# GET /dishes/1/edit
	def edit
		@dish = current_or_guest_user.dishes.find(params[:id])
	end

	# POST /dishes
	# POST /dishes.json
	def create
		@dish = current_or_guest_user.dishes.build(params[cname])
    @dish.restaurant = @restaurant

		respond_to do |format|
			if @dish.save
				format.html { redirect_to @dish, notice: 'Dish was successfully created.' }
				format.json { render json: @dish, status: :created, location: @dish }
			else
				format.html { render action: "new" }
				format.json { render json: @dish.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /dishes/1
	# PUT /dishes/1.json
	def update
		@dish = current_or_guest_user.dishes.find(params[:id])
		@dish.restaurant = @restaurant
		respond_to do |format|
			if @dish.update_attributes(params[:dish])
				format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @dish.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /dishes/1
	# DELETE /dishes/1.json
	def destroy
		@dish = current_or_guest_user.dishes.find(params[:id])
		@dish.destroy

		respond_to do |format|
			format.html { redirect_to dishes_url }
			format.json { head :no_content }
		end
	end
	private
		def load_restaurant
			@restaurant = Restaurant.find_or_create_by_name(params[cname][:restaurant_name])
		end

		def cname
			@cname ||= controller_path.gsub('/', '_').singularize
		end
end
