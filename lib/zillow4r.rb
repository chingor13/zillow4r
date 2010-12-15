require 'rubygems'
require 'pp'
require 'open-uri'
require 'nokogiri'
module Zillow4r

  HTTP_USER_AGENT = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1"
  HTTP_ACCEPT = "text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"
  WEB_API_HOST = "www.zillow.com"
  WEB_API_PORT = 80

  class << self
    attr_accessor :zws_id

    def method_missing(a, *args)
      if match = a.to_s.match(/^fetch_(.*)$/)
        self.fetch(match[1], args[0])
      else
        super(a, *args)
      end
    end

    def fetch(type, params = {})
      klass = get_class(type)
      path = build_path(klass, params)
      url = "http://" + WEB_API_HOST + path
      klass.new(open(url).read)
    end

    def build_path(klass, params)
      p = ["zws-id=#{Zillow4r.zws_id}"]
      params.each do |key,value|
        p << "#{key}=#{URI.escape(value.to_s)}"
      end
      "#{klass.path}?#{p.join('&')}"
    end

    private

    def get_class(type)
      class_name = type.split("_").map{|word| word[0..0].upcase + word[1..word.length]}.join("")
      Zillow4r::Api.const_get(class_name)
    end
  end

end

require 'zillow4r/models.rb'
require 'zillow4r/api.rb'
