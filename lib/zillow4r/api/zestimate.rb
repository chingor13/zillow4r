module Zillow4r
  module Api
    class Zestimate < Zillow4r::Api::Base
      int_point    :zpid, "response zpid", :data
      object_point :zestimate, "response zestimate", :data, Zillow4r::Zestimate
      object_point :address, "response address", :data, Zillow4r::Address
      object_point :links, "response links", :data, Zillow4r::Links

      def self.path
        "/webservice/GetZestimate.htm"
      end

    end
  end
end
