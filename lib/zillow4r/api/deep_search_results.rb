module Zillow4r
  module Api
    class DeepSearchResults < Zillow4r::Api::Base
      data_point :results_data_node, "response results", :data

      def results
        @results ||= results_data_node.children.map{|e| Zillow4r::Property.new(e)}
      end

      def self.path
        "/webservice/GetDeepSearchResults.htm"
      end

    end
  end
end
