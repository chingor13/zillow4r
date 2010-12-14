module Zillow4r
  class Zestimate < Zillow4r::Base
    int_point       :amount, "amount", :data
    attribute_point :amount_currency, "amount", :data, "currency"
    text_point      :last_updated, "last-updated", :data
    int_point       :value_change, "valuechange", :data
    attribute_point :value_change_duration, "valuechange", :data, "duration"
    attribute_point :value_change_currency, "valuechange", :data, "currency"

    int_point       :valuation_low, "valuationrange low", :data
    attribute_point :valuation_low_currency, "valuationrange low", :data, "currency"
    int_point       :valuation_high, "valuationrange high", :data
    attribute_point :valuation_high_currency, "valuationrange high", :data, "currency"

    int_point       :percentile, "percentile", :data
  end
end
