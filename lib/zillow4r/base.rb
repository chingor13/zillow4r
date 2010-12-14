module Zillow4r
  class Base
    attr_reader :data
    def initialize(xml_or_doc)
      @data = xml_or_doc.is_a?(String) ? 
                Nokogiri::HTML(xml_or_doc) :
                xml_or_doc
    end
    include Zillow4r::XmlSearchHelper
  end
end
