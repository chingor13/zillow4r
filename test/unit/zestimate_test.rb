require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class ZestimateTest < ZillowTest

  def no_test_webservice_url
    path = Zillow4r::Api::Zestimate.build_path(:zpid => 48749425)
    assert_equal("/webservice/GetZestimate.htm?zws-id=TEST_ZWS_ID&zpid=48749425", path)
  end

  def test_parsing
    # mock response
    mock_http_response("zestimate.xml")

    response = Zillow4r.fetch_zestimate(:zpid => 48749425)

    assert_equal(0, response.response_code)
    assert_equal("Request successfully processed", response.response_message)

    # check the zestimate data
    zestimate = response.zestimate
    assert(zestimate)
    assert_equal(Zillow4r::Zestimate, zestimate.class)

    assert_equal(1219500, zestimate.amount)
    assert_equal("USD", zestimate.amount_currency)
    assert_equal("11/03/2009", zestimate.last_updated)

    assert_equal(-41500, zestimate.value_change)
    assert_equal("30", zestimate.value_change_duration)
    assert_equal("USD", zestimate.value_change_currency)

    assert_equal(1024380, zestimate.valuation_low)
    assert_equal("USD", zestimate.valuation_low_currency)
    assert_equal(1378035, zestimate.valuation_high)
    assert_equal("USD", zestimate.valuation_high_currency)

    assert_equal(95, zestimate.percentile)

    # check the address data
    address = response.address
    assert(address)
    assert_equal(Zillow4r::Address, address.class)

    assert_equal("2114 Bigelow Ave N", address.street)
    assert_equal("98109", address.zipcode)
    assert_equal("Seattle", address.city)
    assert_equal("WA", address.state)
    assert_equal(47.63793, address.latitude)
    assert_equal(-122.347936, address.longitude)
  end

end
