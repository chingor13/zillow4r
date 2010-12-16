require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class UpdatedPropertyDetailsTest < ZillowTest

  def test_webservice_url
    path = Zillow4r.build_path(Zillow4r::Api::UpdatedPropertyDetails, :zpid => 48749425)
    assert_equal_url("/webservice/GetUpdatedPropertyDetails.htm?zws-id=TEST_ZWS_ID&zpid=48749425", path)
  end

  def test_parsing
    # mock response
    mock_http_response("updated_property_details.xml")

    response = Zillow4r.fetch_updated_property_details(:zpid => 48749425)

    assert_equal(172, response.page_view_count_month)
    assert_equal(4149, response.page_view_count_total)
    assert_equal("2114 Bigelow Ave N", response.address.street)

    # test posting
    posting = response.posting
    assert_equal(Zillow4r::Posting, posting.class)
    assert_equal("John Blacksmith", posting.agent_name)
    assert_equal("/profile/John.Blacksmith", posting.agent_profile_url)
    assert_equal("Lake and Company Real Estate", posting.brokerage)
    assert_equal("For sale by agent", posting.type)
    assert_equal("2008-06-05 10:28:00.0", posting.last_updated_date)
    assert_equal("http://mls.lakere.com/srch_mls/detail.php?mode=ag&LN=28097669&t=listings&l=", posting.external_url)
    assert_equal(28097669, posting.mls)

    assert_equal(1290000, response.price)
    assert_equal("USD", response.price_currency)

    assert(response.links.links.length > 0)
    assert(response.images.images.length > 0)

    # test facts
    assert_equal("Single family", response.use_code)
    assert_equal(4, response.bedrooms)
    assert_equal(3.0, response.bathrooms)
    assert_equal(3470, response.finished_sq_ft)
    assert_equal(4680, response.lot_sq_ft)
    assert_equal(1924, response.year_built)
    assert_equal(2003, response.year_updated)
    assert_equal(2, response.floors)
    assert_equal("Finished", response.basement)
    assert_equal("Composition", response.roof)
    assert_equal("Water, City, Mountain", response.view)
    assert_equal("Off-street", response.parking_type)
    assert_equal("Gas", response.heating_sources)
    assert_equal("Forced air", response.heating_system)
    assert_equal("Dishwasher, Dryer, Freezer, Garbage disposal, Microwave, Range / Oven, Refrigerator, Washer", response.appliances)
    assert_equal("Hardwood, Carpet, Tile", response.floor_covering)
    assert_equal("Laundry room, Walk-in closet, Master bath, Office, Dining room, Family room, Breakfast nook", response.rooms)

    # test general info
    assert_equal("Bright, spacious, 4 bedroom/3 bath Craftsman, with stunning, expansive views, on one of Queen Anne's finest streets. Views of Lk Union, Lk Washington,the Cascades from Mt. Baker to Mt. Rainier, and the city-from two levels and 2 view decks. Craftsman charm intact: hardwood floors, cove moldings, crystal doorknobs, Batchelder tile fireplace. Huge gourmet eat-in kitchen with slab granite countertops, deluxe master suite, theater-like media room, level rear yard with garden space and covered patio.", response.home_description)
    assert_equal("Queen Anne", response.neighborhood)
    assert_equal("Seattle", response.school_district)
    assert_equal("John Hay", response.elementary_school)
    assert_equal("McClure", response.middle_school)
  end

end

