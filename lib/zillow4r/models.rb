module Zillow4r
  module XmlSearchHelper
    module ClassMethods
      def data_point(method_name, definition, source, post_value = nil)
        definition = Array(definition)
        send(:define_method, method_name) do
          value = instance_variable_get("@#{method_name}")
          return value unless value.nil?

          data = send(source)
          return nil if data.nil?

          value = find_attribute(definition, data)
          return nil if value.nil? || value.empty?

          if post_value
            if post_value.respond_to?(:call)
              value = post_value.call(value)
            else
              value = value.send(post_value).strip
            end
          end
          instance_variable_set("@#{method_name}", value)
          value
        end
      end

      def int_point(method_name, definition, source)
        data_point method_name, definition, source, lambda{|e| e.inner_text.to_i}
      end

      def float_point(method_name, definition, source)
        data_point method_name, definition, source, lambda{|e| e.inner_text.to_f}
      end

      def text_point(method_name, definition, source)
        data_point method_name, definition, source, :inner_text
      end

      def attribute_point(method_name, definition, source, attribute_name)
        data_point method_name, definition, source, lambda{|e| attr = e.attribute(attribute_name.to_s).value}
      end

      def array_point(method_name, definition, source, klass)
        data_point method_name, definition, source, lambda{|e| e.children.map{|c| klass.new(c)}}
      end

      def object_point(method_name, definition, source, klass)
        data_point method_name, definition, source, lambda{|e| klass.new(e)}
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    private

    def find_attribute(definition, data)
      return nil if data.nil?
      return data if definition.empty?
      definition = definition.dup
      attribute = definition.shift
      if attribute.is_a?(Hash)
        new_data = data.children.detect{|e| attribute.all?{|k,v| child = e.children.detect{|c| c.name == k}; child.inner_text.strip == v}}
        return find_attribute(definition, new_data)
      else
        # attribute is a String
        return find_attribute(definition, data.search(attribute))
      end
    end
  end

  class Base
    attr_reader :data
    def initialize(xml_or_doc)
      @data = xml_or_doc.is_a?(String) ? 
                Nokogiri::HTML(xml_or_doc) :
                xml_or_doc
    end
    include Zillow4r::XmlSearchHelper
  end

  class Address < Zillow4r::Base
    text_point  :street, "street", :data
    text_point  :zipcode, "zipcode", :data
    text_point  :city, "city", :data
    text_point  :state, "state", :data
    float_point :latitude, "latitude", :data
    float_point :longitude, "longitude", :data
  end

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

  class Region < Zillow4r::Base
    int_point   :id, "id", :data
    float_point :latitude, "latitude", :data
    float_point :longitude, "longitude", :data

    # may or may not be available
    text_point  :state, "state", :data
    text_point  :city, "city", :data
    text_point  :neighborhood, "neighborhood", :data
    text_point  :name, "name", :data
    text_point  :url, "url", :data
    int_point   :zindex, "zindex", :data
    attribute_point :zindex_currency, "zindex", :data, "currency"
  end

  class Posting < Zillow4r::Base
    text_point :status, "status", :data
    text_point :agent_name, "agentname", :data
    text_point :agent_profile_url, "agentprofileurl", :data
    text_point :brokerage, "brokerage", :data
    text_point :type, "type", :data
    text_point :last_updated_date, "lastupdateddate", :data
    text_point :external_url, "externalurl", :data
    int_point :mls, "mls", :data
  end

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
    object_point    :links, "links", :data, Zillow4r::Links
  end

  class ComparableProperty < Zillow4r::Property
    def score
      data.attribute("score").value.to_f
    end
  end

end
