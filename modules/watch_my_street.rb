class Modules::WatchMyStreet

  BASE_URL = 'http://www.watchmystreet.co.nz'

  SEARCH_URL = BASE_URL + '/cities.json?q=%s'
  DATA_URL = BASE_URL + '%s'

  def matches(address)
    true
  end

  def get_info(address)
    search_url = SEARCH_URL % URI.encode_www_form_component([address])
    results = JSON.parse(HTTParty.get(search_url).body)
    return {error: :property_not_found} if results.empty?
    return {error: :multiple_results, num_results: results.size} if results.size > 1
    path = results[0]['metadata']['path']

    data_url = DATA_URL % path
    page = Nokogiri::HTML(HTTParty.get(data_url).body)

    valuation = page.css('ul.valuation li:first em').text.gsub(' K', ',000')
    floor_area = get_attribute page, 'Floor Area'
    land_area = get_attribute page, 'Land Area'
    building_age = get_attribute page, 'Building Age'

    {valuation: valuation, floor_area: floor_area, land_area: land_area, building_age: building_age}
  end

  private

  def get_attribute(page, title)
    page.css('.details > table tr > th').find{ |el| el.text.strip == title }.css('~ td').text.strip
  end

end
