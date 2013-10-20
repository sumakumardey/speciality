class ReviewsController < ApplicationController

  # GET /reviews/1/edit
  def edit
    @review = @dish.reviews.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = current_or_guest_user.reviews.new(params[:review])
    @review.dish = @dish
    @review.score = params[:score]

    if @review.save
      flash[:notice] = "The review has been added."
    else
      flash[:notice] = "Something went wrong."
    end

    respond_to do |format|
      format.js
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = current_or_guest_user.reviews.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = @dish.reviews.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

  private

  def load_dish
    @dish = Dish.find(params[cname][:dish_id])
  end

  def cname
    @cname ||= controller_path.gsub('/', '-').singularize
  end
end
