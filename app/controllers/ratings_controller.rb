class RatingsController < ApplicationController
  before_action :set_lists, only: [:index]

  def index
    # Fragment cacheys ja kontrollerin tarvitsemien tietojen cacheys
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  private
  def set_lists
    @recent = Rails.cache.fetch('recent_ratings', expires_in: 10.minutes) { Rating.recent }
    @breweries = Rails.cache.fetch('top_breweries', expires_in: 10.minutes) { Brewery.top 3 }
    @beers = Rails.cache.fetch('top_beers', expires_in: 10.minutes) { Beer.top 3 }
    @users = Rails.cache.fetch('top_most_ratings', expires_in: 10.minutes) { User.top_most_ratings 3 }
    @styles = Rails.cache.fetch('top_styles', expires_in: 10.minutes) { Style.top 3 }
    @ratings = Rails.cache.fetch('all_ratings', expires_in: 10.minutes) { Rating.all }
  end
end