class BeermappingApi
    def self.places_in(city)
      city = city.downcase
      Rails.cache.fetch(city, :expires_in => 7.days) { fetch_places_in(city) }
    end

    def self.place_with_id(id)
      Rails.cache.fetch(id, :expires_in => 7.days) { fetch_place_with_id(id)}
    end

    private

    def self.fetch_place_with_id(id)
      url = "http://beermapping.com/webservice/locquery/f063efd4be83194eefec2cd139c7cad8/#{id}"
      response = HTTParty.get "#{url}"
      location = response.parsed_response["bmp_locations"]["location"]
      Place.new(location)
    end

    def self.fetch_places_in(city)
      url = "http://beermapping.com/webservice/loccity/#{key}/"

      response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
      places = response.parsed_response["bmp_locations"]["location"]

      return [] if places.is_a?(Hash) and places['id'].nil?

      places = [places] if places.is_a?(Hash)
      places.inject([]) do | set, place |
        set << Place.new(place)
      end
    end

  def self.key
    "c34c664bd9eea6c8c3b6c089d7efc0c2"
  end
end