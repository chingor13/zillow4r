module Zillow4r
  class ComparableProperty < Zillow4r::Property
    def score
      data.attribute("score").value.to_f
    end
  end
end
