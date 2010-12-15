module Zillow4r
  module Api
    class RegionChildren < Zillow4r::Api::Base
      data_point :response_node, "response", :data
      def region
        @region ||= Zillow4r::Region.new(response_node.children.detect{|e| e.name == "region"})
      end

      text_point :subregion_type, "response subregiontype", :data
      data_point :children_node, "response list", :data

      def children
        @children ||= children_node.children.map{|e| Zillow4r::Region.new(e)}
      end

      def self.path
        "/webservice/GetRegionChildren.htm"
      end

    end
  end
end
