module Zillow4r
  class Address < Zillow4r::Base
    text_point  :street, "street", :data
    text_point  :zipcode, "zipcode", :data
    text_point  :city, "city", :data
    text_point  :state, "state", :data
    float_point :latitude, "latitude", :data
    float_point :longitude, "longitude", :data
  end
end
