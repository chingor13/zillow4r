module Zillow4r
  module Api
    class SearchResults < Zillow4r::Api::Base
      array_point :results, "response/results", :data, Zillow4r::Property

      def self.path
        "/webservice/GetSearchResults.htm"
      end

    end
  end
end
