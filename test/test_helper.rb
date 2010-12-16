# add to the load path (done by loading gems for you, just not in test)
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

# require dependencies
require 'bundler'
require 'test/unit'
Bundler.setup
Bundler.require(:default)
Bundler.require(:development)
require 'uri'

# require the files
require 'zillow4r'

# set a dummy ZWS_ID
Zillow4r.zws_id = "TEST_ZWS_ID"

FIXTURE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))

class ZillowTest < Test::Unit::TestCase

  protected

  def assert_equal_url(url1, url2)
    uri1 = URI.parse(url1)
    uri2 = URI.parse(url2)
    assert_equal(uri1.host, uri2.host)
    assert_equal(uri1.port, uri2.port)
    assert_equal(uri1.path, uri2.path)
    query_params1 = uri1.query.split("&").sort
    query_params2 = uri2.query.split("&").sort
    assert_equal(query_params1, query_params2)
  end

  def mock_http_response(filename)
    OpenURI.stubs(:open_uri).returns(File.open(FIXTURE_PATH + "/#{filename}"))
  end
end
