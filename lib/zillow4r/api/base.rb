require 'nokogiri'
module Zillow4r
  module Api
    class Base
      SUCCESS = 0
      SERVICE_ERROR = 1
      DATA_ERROR = 2

      attr_reader :data
      def initialize(xml)
        @data = Nokogiri::HTML(xml)
      end

      class << self
        def data_point(attribute_name, definition, source, post_value = nil)
          definition = Array(definition)
          send(:define_method, attribute_name) do
            value = instance_variable_get("@#{attribute_name}")
            return value unless value.nil?

            data = send(source)
            return nil if data.nil?

            value = find_attribute(definition, data)
            if post_value
              if post_value.respond_to?(:call)
                value = post_value.call(value)
              else
                value = value.send(post_value).strip
              end
            end
            instance_variable_set("@#{attribute_name}", value)
            value
          end
        end

        def int_point(attribute_name, definition, source)
          data_point attribute_name, definition, source, lambda{|e| e.inner_text.to_i}
        end

        def float_point(attribute_name, definition, source)
          data_point attribute_name, definition, source, lambda{|e| e.inner_text.to_f}
        end

        def text_point(attribute_name, definition, source)
          data_point attribute_name, definition, source, :inner_text
        end

        def build_path(params = {})
          p = ["zws-id=#{Zillow4r.zws_id}"]
          params.each do |key,value|
            p << "#{key}=#{URI.escape(value.to_s)}"
          end
          "#{path}?#{p.join('&')}"
        end

        def path
          raise "Need to set path for child class"
        end
      end

      int_point "response_code", "message code", "data"
      data_point "response_message", "message text", "data", "inner_text"

      def data_error?
        response_code.nil? || response_code > 500
      end

      def error?
        response_code.nil? || response_code > 0
      end

      private

      def find_attribute(definition, data)
        return nil if data.nil?
        return data if definition.empty?

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
  end
end
