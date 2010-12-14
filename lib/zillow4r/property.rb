module Zillow4r
  class Property < Zillow4r::Base
    int_point       :zpid, "zpid", :data
    int_point       :tax_assessment_year, "taxassessmentyear", :data
    float_point     :tax_assessment, "taxassessment", :data
    int_point       :year_built, "yearbuilt", :data
    int_point       :lot_size_sq_ft, "lotsizesqft", :data
    int_point       :finished_sq_ft, "finishedsqft", :data
    float_point     :bathrooms, "bathrooms", :data
    int_point       :bedrooms, "bedrooms", :data
    text_point      :last_sold_date, "lastsolddate", :data
    int_point       :last_sold_price, "lastsoldprice", :data
    attribute_point :last_sold_currency, "lastsoldprice", :data, "currency"

    object_point    :address, "address", :data, Zillow4r::Address
    object_point    :zestimate, "zestimate", :data, Zillow4r::Zestimate
  end
end
