module Zillow4r
  class Images < Zillow4r::Base
    attr_reader :images
    def initialize(xml)
      super(xml)
      @images = []
      @data.children.each do |e|
        @images << e.inner_text.strip
      end
    end

    def [](index)
      @images[index]
    end
  end
end
