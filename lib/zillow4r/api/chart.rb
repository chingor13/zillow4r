module Zillow4r
  module Api
    class Chart < Zillow4r::Api::Base
      text_point :chart_url, "response url", :data

      def self.path
        "/webservice/GetChart.htm"
      end

    end
  end
end
