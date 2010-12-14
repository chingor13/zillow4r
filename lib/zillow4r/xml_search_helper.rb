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
        data_point method_name, definition, source, lambda{|e| e.attribute(attribute_name).value}
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
