require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class DemographicsTest < ZillowTest

  def test_webservice_url
    path = Zillow4r::Api::Demographics.build_path(:city => "Seattle", :state => "WA")
    assert_equal("/webservice/GetDemographics.htm?zws-id=TEST_ZWS_ID&city=Seattle&state=WA", path)
  end

  def test_parsing
    # mock response
    mock_http_response("demographics.xml")

    response = Zillow4r.fetch_demographics(:city => "Seattle", :state => "WA")
    assert_equal("http://www.zillow.com/homes/for_sale/Ballard-Seattle-WA/", response.link_url)
    assert_equal(37, response.median_age)
    assert_equal(45736, response.median_household_income)
    assert_equal(2.08, response.average_household_size)
    assert_equal(0.181808339938523, response.percent_of_homes_with_kids)
    assert_equal(0.35028618, response.percent_owners)
    assert_equal(0.64971382, response.percent_renters)
  end

end
