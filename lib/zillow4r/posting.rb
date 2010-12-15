module Zillow4r
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
end
