class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @beers = Beer.all
    @rating = Rating.new

  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    current_user.ratings << @rating
    redirect_to current_user
  end


  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to :back
  end

end


