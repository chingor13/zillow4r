module Zillow4r
  module Api
    class Demographics < Zillow4r::Api::Base
      # intermediate points
      data_point :people_data_node, ["response pages", {"name" => "People"}, "tables", {"name" => "People Data"}, "data"], :data
      data_point :owners_data_node, ["response pages", {"name" => "Homes & Real Estate"}, "tables", {"name" => "Census Summary-Occupancy"}, "data"], "data"

      text_point :link_url, "response links forsale", :data
      int_point :median_age, [{"name" => "Median Age"}, "values city value"], :people_data_node
      int_point :median_household_income, [{"name" => "Median Household Income"}, "values city value"], :people_data_node
      float_point :average_household_size, [{"name" => "Average Household Size"}, "values city value"], :people_data_node
      float_point :percent_of_homes_with_kids, [{"name" => "Homes With Kids"}, "values city value"], :people_data_node

      float_point :percent_owners, [{"name" => "Own"}, "value"], :owners_data_node
      float_point :percent_renters, [{"name" => "Rent"}, "value"], :owners_data_node

      def self.path
        "/webservice/GetDemographics.htm"
      end

    end
  end
end
