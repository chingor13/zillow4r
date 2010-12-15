module Zillow4r
  class Region < Zillow4r::Base
    int_point   :id, "id", :data
    float_point :latitude, "latitude", :data
    float_point :longitude, "longitude", :data

    # may or may not be available
    text_point  :state, "state", :data
    text_point  :city, "city", :data
    text_point  :neighborhood, "neighborhood", :data
    text_point  :name, "name", :data
    text_point  :url, "url", :data
    int_point   :zindex, "zindex", :data
    attribute_point :zindex_currency, "zindex", :data, "currency"
  end
end
