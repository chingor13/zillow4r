module Zillow4r
  class Links < Zillow4r::Base
    attr_reader :links
    def initialize(xml)
      super(xml)
      @links = {}
      @data.children.each do |e|
        @links[e.name] = e.inner_text.strip
      end
    end

    def [](name)
      @links[name]
    end
  end
end
