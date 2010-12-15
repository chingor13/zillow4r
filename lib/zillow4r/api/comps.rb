module Zillow4r
  module Api
    class Comps < Zillow4r::Api::Base
      object_point :principal, "response properties principal", :data, Zillow4r::Property
      data_point :comparables_data_node, "response properties", :data, lambda{|e| e.children.detect{|c| c.name == "comparables"}}
      def comparables
        @comparables ||= begin
          comparables_data_node.children.map{|e| Zillow4r::ComparableProperty.new(e)}
        end
      end

      def self.path
        "/webservice/GetChart.htm"
      end

    end
  end
end
