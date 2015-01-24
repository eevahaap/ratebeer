class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render :index
  end
end