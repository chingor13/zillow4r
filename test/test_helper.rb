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

  def mock_http_response(filename)
    OpenURI.stubs(:open_uri).returns(File.open(FIXTURE_PATH + "/#{filename}"))
  end
end
