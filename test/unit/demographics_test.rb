require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class DemographicsTest < ZillowTest

  def test_webservice_url
    path = Zillow4r.build_path(Zillow4r::Api::Demographics, :city => "Seattle", :state => "WA")

    u1 = URI.parse(path)
    u2 = URI.parse("/webservice/GetDemographics.htm?zws-id=TEST_ZWS_ID&city=Seattle&state=WA")
    assert_equal(u2, u1)
  end

  def test_parsing
    # mock response
    mock_http_response("demographics.xml")

    response = Zillow4r.fetch_demographics(:city => "Seattle", :state => "WA")
    assert_equal("http://www.zillow.com/homes/for_sale/Ballard-Seattle-WA/", response.links["forsale"])

    # test city demographics
    assert_equal(37, response.city_median_age)
    assert_equal(45736, response.city_median_household_income)
    assert_equal(2.08, response.city_average_household_size)
    assert_equal(0.181808339938523, response.city_percent_of_homes_with_kids)

    # test neighborhood demographics
    assert_equal(39, response.neighborhood_median_age)
    assert_equal(41202.9453206937, response.neighborhood_median_household_income)
    assert_equal(1.82278897942217, response.neighborhood_average_household_size)
    assert_equal(0.149933859172205, response.neighborhood_percent_of_homes_with_kids)

    # test nation demographics
    assert_equal(36, response.nation_median_age)
    assert_equal(44512.0130806292, response.nation_median_household_income)
    assert_equal(2.58883240001203, response.nation_average_household_size)
    assert_equal(0.313623902816284, response.nation_percent_of_homes_with_kids)

    assert_equal(0.35028618, response.percent_owners)
    assert_equal(0.64971382, response.percent_renters)
  end

end
