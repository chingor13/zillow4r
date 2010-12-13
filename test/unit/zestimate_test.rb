require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class ZestimateTest < ZillowTest

  def test_webservice_url
    path = Zillow4r::Api::Zestimate.build_path(:zpid => 48749425)
    assert_equal("/webservice/GetZestimate.htm?zws-id=TEST_ZWS_ID&zpid=48749425", path)
  end

  def test_parsing
    # mock response
    mock_http_response("zestimate.xml")

    response = Zillow4r.fetch_zestimate(:zpid => 48749425)
    assert_equal(1219500, response.amount)
    assert_equal("USD", response.currency)
    assert_equal("11/03/2009", response.last_updated)
    assert_equal(95, response.percentile)
  end

end
