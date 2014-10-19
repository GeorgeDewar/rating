class Modules::WatchMyStreet

  SEARCH_URL = 'http://www.watchmystreet.co.nz/cities.json?q=%s'

  def matches(address)
    true
  end

  def get_info(address)
    search_url = SEARCH_URL % URI.encode_www_form_component([address])
    results = JSON.parse(HTTParty.get(search_url).body)
    return {error: :property_not_found} if results.empty?
    return {error: :multiple_results, num_results: results.size} if results.size > 1
    path = results[0]['metadata']['path'];

    puts path
  end

end
