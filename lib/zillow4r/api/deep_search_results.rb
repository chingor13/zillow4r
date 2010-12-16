module Zillow4r
  module Api
    class DeepSearchResults < Zillow4r::Api::Base
      array_point :results, "response/results", :data, Zillow4r::Property

      def self.path
        "/webservice/GetDeepSearchResults.htm"
      end

    end
  end
end
