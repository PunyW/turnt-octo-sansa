class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeerMappingApi.places_in(params[:city])
    if @places.empty?
      session[:last_city] = nil
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city] = params[:city]
      render :index
    end
  end

  def show
    id = params[:id]
    city = session[:last_city]
    address = nil
    Rails.cache.read(city).each do | place |
      if place.id == id
        address = ERB::Util.url_encode("#{place.name} at #{place.street}, #{city}, #{place.country}") if place.id == id
        @place = place
      end

    end

    @url = "https://www.google.com/maps/embed/v1/place?key=#{key}&q=#{address}"
  end

  private
      def key
      raise 'MAPSAPIKEY env variable not defined' if ENV['MAPSAPIKEY'].nil?
      ENV['MAPSAPIKEY']
    end
end