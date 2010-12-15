require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class DeepCompsTest < ZillowTest

  def test_parsing
    # mock response
    mock_http_response("deep_comps.xml")

    response = Zillow4r.fetch_deep_comps(:zpid => 48749425, :count => 5)

    # test principal property
    principal = response.principal
    assert(principal)
    assert_equal(Zillow4r::Property, principal.class)
    assert_equal(48749425, principal.zpid)

    principal_address = principal.address
    assert(principal_address)
    assert_equal(Zillow4r::Address, principal_address.class)
    assert_equal("2114 Bigelow Ave N", principal_address.street)

    principal_zestimate = principal.zestimate
    assert(principal_zestimate)
    assert_equal(Zillow4r::Zestimate, principal_zestimate.class)
    assert_equal(1219500, principal_zestimate.amount)

    # test comparables
    comparables = response.comparables
    assert_equal(5, comparables.length)
    comparables.each do |comparable|
      assert_equal(Zillow4r::ComparableProperty, comparable.class)
      # just make sure we're parsing something instead of testing every value
      assert(comparable.zestimate.amount)
      assert(comparable.address.street)
      assert(comparable.links.links.length > 0)
    end

    assert_equal(0.156502, comparables[0].score)
    assert_equal(0.156114, comparables[1].score)
    assert_equal(0.153359, comparables[2].score)
    assert_equal(0.15329, comparables[3].score)
    assert_equal(0.153177, comparables[4].score)
  end

end
