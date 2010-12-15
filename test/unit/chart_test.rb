require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class ChartTest < ZillowTest

  def test_parsing
    # mock response
    mock_http_response("chart.xml")

    response = Zillow4r.fetch_chart("unit-type" => "percent", "zpid" => 48749425, "width" => 300, "height" => 150)
    assert_equal("http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425", response.chart_url)
  end

end
