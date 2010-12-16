require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class RegionChildrenTest < ZillowTest

  def test_webservice_url
    path = Zillow4r.build_path(Zillow4r::Api::RegionChildren, :city => "seattle", :state => "WA", :childtype => "neighborhood")

    u1 = URI.parse(path)
    u2 = URI.parse("/webservice/GetRegionChildren.htm?zws-id=TEST_ZWS_ID&city=seattle&state=WA&childtype=neighborhood")
    assert_equal(u2, u1)
  end

  def test_parsing
    # mock response
    mock_http_response("region_children.xml")

    response = Zillow4r.fetch_region_children(:city => "seattle", :state => "WA", :childtype => "neighborhood")

    assert_equal("neighborhood", response.subregion_type)

    # test region
    region = response.region
    assert(region)
    assert_equal(Zillow4r::Region, region.class)
    assert_equal(16037, region.id)
    assert_equal("Washington", region.state)
    assert_equal("Seattle", region.city)
    assert_equal(47.590955, region.latitude)
    assert_equal(-122.382608, region.longitude)

    # test children
    children = response.children
    assert(children.is_a?(Array))
    assert_equal(106, children.length)
    children.each do |child|
      assert_equal(Zillow4r::Region, child.class)
      assert(child.name)
      assert(child.url)
      assert(child.latitude)
      assert(child.longitude)
    end
  end

end
