module Zillow4r
  module Api
    class RegionChildren < Zillow4r::Api::Base
      object_point :region, "response/region", :data, Zillow4r::Region
      text_point :subregion_type, "response subregiontype", :data
      array_point :children, "response/list", :data, Zillow4r::Region

      def self.path
        "/webservice/GetRegionChildren.htm"
      end

    end
  end
end
