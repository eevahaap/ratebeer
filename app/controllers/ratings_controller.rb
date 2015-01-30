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

    # talletetaan tehdyn reittauksen sessioon
    session[:last_rating] = "#{@rating.beer.name} #{@rating.score} points"

    redirect_to ratings_path
  end


  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path

  end

end


