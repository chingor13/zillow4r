module Zillow4r
  module Api
    class Demographics < Zillow4r::Api::Base
      object_point :region, "response region", :data, Zillow4r::Region
      object_point :links, "response links", :data, Zillow4r::Links

      # intermediate points
      data_point :people_data_node, ["response pages", {"name" => "People"}, "tables", {"name" => "People Data"}, "data"], :data
      data_point :owners_data_node, ["response pages", {"name" => "Homes & Real Estate"}, "tables", {"name" => "Census Summary-Occupancy"}, "data"], "data"

      # city demographic values
      float_point :city_median_age, [{"name" => "Median Age"}, "values city value"], :people_data_node
      float_point :city_median_household_income, [{"name" => "Median Household Income"}, "values city value"], :people_data_node
      float_point :city_average_household_size, [{"name" => "Average Household Size"}, "values city value"], :people_data_node
      float_point :city_percent_of_homes_with_kids, [{"name" => "Homes With Kids"}, "values city value"], :people_data_node

      # neighborhood demographic values
      float_point :neighborhood_median_age, [{"name" => "Median Age"}, "values neighborhood value"], :people_data_node
      float_point :neighborhood_median_household_income, [{"name" => "Median Household Income"}, "values neighborhood value"], :people_data_node
      float_point :neighborhood_average_household_size, [{"name" => "Average Household Size"}, "values neighborhood value"], :people_data_node
      float_point :neighborhood_percent_of_homes_with_kids, [{"name" => "Homes With Kids"}, "values neighborhood value"], :people_data_node

      # nation demographic values
      float_point :nation_median_age, [{"name" => "Median Age"}, "values nation value"], :people_data_node
      float_point :nation_median_household_income, [{"name" => "Median Household Income"}, "values nation value"], :people_data_node
      float_point :nation_average_household_size, [{"name" => "Average Household Size"}, "values nation value"], :people_data_node
      float_point :nation_percent_of_homes_with_kids, [{"name" => "Homes With Kids"}, "values nation value"], :people_data_node

      float_point :percent_owners, [{"name" => "Own"}, "value"], :owners_data_node
      float_point :percent_renters, [{"name" => "Rent"}, "value"], :owners_data_node

      def self.path
        "/webservice/GetDemographics.htm"
      end

    end
  end
end
