module Zillow4r
  module Api
    class Base < Zillow4r::Base
      def self.path
        raise "Need to set path for child class"
      end

      int_point "response_code", "message code", "data"
      text_point "response_message", "message text", "data"

      def data_error?
        response_code.nil? || response_code > 500
      end

      def error?
        response_code.nil? || response_code > 0
      end
    end
  end
end

Dir.glob(File.dirname(__FILE__) + "/api/*.rb").each do |file|
  require file
end

