module Zillow4r
  module Api
    class UpdatedPropertyDetails < Zillow4r::Api::Base
      int_point :zpid, "response zpid", :data

      # page views
      int_point :page_view_count_month, "response pageviewcount currentmonth", :data
      int_point :page_view_count_total, "response pageviewcount total", :data

      object_point :address, "response address", :data, Zillow4r::Address
      object_point :posting, "response posting", :data, Zillow4r::Posting

      # price
      int_point :price, "response price", :data
      attribute_point :price_currency, "response price", :data, "currency"

      object_point :links, "response links", :data, Zillow4r::Links
      object_point :images, "response images image", :data, Zillow4r::Images

      # facts
      data_point :facts_data_node, "response editedfacts", :data
      text_point :use_code, "usecode", :facts_data_node
      int_point :bedrooms, "bedrooms", :facts_data_node
      float_point :bathrooms, "bathrooms", :facts_data_node
      int_point :finished_sq_ft, "finishedsqft", :facts_data_node
      int_point :lot_sq_ft, "lotsizesqft", :facts_data_node
      int_point :year_built, "yearbuilt", :facts_data_node
      int_point :year_updated, "yearupdated", :facts_data_node
      int_point :floors, "numfloors", :facts_data_node
      text_point :basement, "basement", :facts_data_node
      text_point :roof, "roof", :facts_data_node
      text_point :view, "view", :facts_data_node
      text_point :parking_type, "parkingtype", :facts_data_node
      text_point :heating_sources, "heatingsources", :facts_data_node
      text_point :heating_system, "heatingsystem", :facts_data_node
      text_point :appliances, "appliances", :facts_data_node
      text_point :floor_covering, "floorcovering", :facts_data_node
      text_point :rooms, "rooms", :facts_data_node

      # general info
      text_point :home_description, "response homedescription", :data
      text_point :neighborhood, "response neighborhood", :data
      text_point :school_district, "response schooldistrict", :data
      text_point :elementary_school, "response elementaryschool", :data
      text_point :middle_school, "response middleschool", :data

      def self.path
        "/webservice/GetUpdatedPropertyDetails.htm"
      end
    end
  end
end
