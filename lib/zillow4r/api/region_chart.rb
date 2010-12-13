module Zillow4r
  module Api
    class RegionChart < Zillow4r::Api::Base
      data_point :chart_url, "response url", :data

      def self.path
        "/webservice/GetRegionChart.htm"
      end

    end
  end
end
