module Zillow4r
  class Region < Zillow4r::Base
    int_point   :id, "id", :data
    text_point  :state, "state", :data
    text_point  :city, "city", :data
    text_point  :neighborhood, "neighborhood", :data
    float_point :latitude, "latitude", :data
    float_point :longitude, "longitude", :data

  end
end
