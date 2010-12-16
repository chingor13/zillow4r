require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class RegionChartTest < ZillowTest

  def test_webservice_url
    path = Zillow4r.build_path(Zillow4r::Api::RegionChart, "unit-type" => "percent", :city => "seattle", :state => "WA", :width => 300, :height => 150)

    u1 = URI.parse(path)
    u2 = URI.parse("/webservice/GetRegionChart.htm?zws-id=TEST_ZWS_ID&unit-type=percent&city=seattle&state=WA&width=300&height=150")
    assert_equal(u2, u1)
  end

  def test_parsing
    # mock response
    mock_http_response("region_chart.xml")

    response = Zillow4r.fetch_region_chart("unit-type" => "percent", :city => "seattle", :state => "WA", :width => 300, :height => 150)
    assert_equal("http://www.zillow.com/app?chartDuration=1year&chartType=partner&cityRegionId=5470&countyRegionId=0&height=150&nationRegionId=0&page=webservice%2FGetRegionChart&service=chart&showCity=true&showPercent=true&stateRegionId=0&width=300&zipRegionId=0", response.chart_url)
  end

end
