require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class DeepSearchResultsTest < ZillowTest

  def test_parsing
    # mock response
    mock_http_response("deep_search_results.xml")

    response = Zillow4r.fetch_deep_search_results(:address => "2114 Bigelow Ave", :citystatezip => "Seattle, WA")

    # test results
    results = response.results
    assert_equal(1, results.length)

    result = results.first
    assert_equal(Zillow4r::Property, result.class)
    assert_equal(48749425, result.zpid)
    assert(result.links.links.length > 0)
    assert(result.address.street)
    assert(result.zestimate.amount)
  end

end
