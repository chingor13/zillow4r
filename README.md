Zillow4r
--------

Simple ruby interface for the [Zillow API](http://www.zillow.com/howto/api/APIOverview.htm).

### Documentation & Requirements
* Nokogiri

### Supported API Calls

As of version 0.1.0, we support the following API calls:

* [GetZestimate](http://www.zillow.com/howto/api/GetZestimate.htm)
* [GetSearchResults](http://www.zillow.com/howto/api/GetSearchResults.htm)
* [GetChart](http://www.zillow.com/howto/api/GetChart.htm)
* [GetComps](http://www.zillow.com/howto/api/GetComps.htm)
* [GetDeepComps](http://www.zillow.com/howto/api/GetDeepComps.htm)
* [GetDeepSearchResults](http://www.zillow.com/howto/api/GetDeepSearchResults.htm)
* [GetUpdatedPropertyDetails](http://www.zillow.com/howto/api/GetUpdatedPropertyDetails.htm)
* [GetDemographics](http://www.zillow.com/howto/api/GetDemographics.htm)
* [GetRegionChildren](http://www.zillow.com/howto/api/GetRegionChildren.htm)
* [GetRegionChart](http://www.zillow.com/howto/api/GetRegionChart.html)

To make these calls, you call the module method `Zillow4r.fetch_[name]` where name is the underscored
api call name without the "Get".  For example, if you wanted to call the GetDeepSearchResults
API, call `Zillow4r.fetch_deep_search_results` with the search parameters specified by the API.

Note: Zillow4r will automatically add your ZWSID to the API request.

### Examples

Basic usage:

    require 'rubygems'
    require 'zillow4r'

    Zillow4r.zws_id = 'YOUR_API_KEY'

    response = Zillow4r.fetch_updated_property_details(:zpid => 123456)
    response.class
    =>  Zillow4r::Api::UpdatedPropertyDetails

    response = Zillow4r.fetch_search_results(:address => "2114 Bigelow Ave", :citystatezip => "Seattle, WA")
    response.class
    =>  Zillow4r::Api::SearchResults
    response.results.class
    =>  Array
    response.results.first.class
    =>  Zillow4r::Property

### Models

Zillow4r uses several intermediate data models which represent repeated data structures contained within
Zillow's xml.  These include:

* Zillow4r::Address
* Zillow4r::Links
* Zillow4r::Images
* Zillow4r::Region
* Zillow4r::Property
* Zillow4r::Posting
* Zillow4r::Zestimate
* Zillow4r::ComparableProperty

These models define the data that they contain through their position within the xml data.

### Testing

Test cases are mocked using the sample API output provided for each API call in the documentation from Zillow.
