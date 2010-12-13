module Zillow4r
  module Api
    class Zestimate < Zillow4r::Api::Base
      # intermediate points
      data_point :zestimate_data, "response zestimate", :data
      data_point :address_data, "response address", :data

      int_point :zpid, "response zpid", :data
      text_point :homedetails_url, "response links homedetails", :data
      text_point :graphsanddata_url, "response links graphsanddata", :data
      text_point :mapthishome_url, "response links mapthishome", :data
      text_point :myestimator_url, "response links myestimator", :data
      text_point :comparables_url, "response links comparables", :data

      # real accessors
      int_point :amount, "amount", :zestimate_data
      data_point :currency, "amount", :zestimate_data:, lambda{|e| e.attribute("currency").value}
      text_point :last_updated, "last-updated", :zestimate_data
      int_point :percentile, "percentile", :zestimate_data

      def self.path
        "/webservice/GetZestimate.htm"
      end

    end
  end
end
