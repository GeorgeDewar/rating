class RatingModule
  STREET_MAPPING = {
    # Street types
    'Ave' => 'Avenue',
    'Cl' => 'Close',
    'Crt' => 'Court',
    'Cres' => 'Crescent',
    'Dr' => 'Drive',
    'Esp' => 'Esplanade',
    'Gr' => 'Grove',
    'Grv' => 'Grove',
    'Hts' => 'Heights',
    'Hwy' => 'Highway',
    'Hl' => 'Hill',
    'Lane' => 'Lane',
    'Line' => 'Line',
    'Mall' => 'Mall',
    'Pde' => 'Parade',
    'Pl' => 'Place',
    'Qy' => 'Quay',
    'Rise' => 'Rise',
    'Rd' => 'Road',
    'Sq' => 'Square',
    'St' => 'Street',
    'Tce' => 'Terrace',
    'Way' => 'Way',

    # Directions
    'N' => 'North',
    'E' => 'East',
    'S' => 'South',
    'W' => 'West',
    'NE' => 'Northeast',
    'SE' => 'Southeast',
    'NW' => 'Northwest',
    'SW' => 'Southwest',
    'Upr' => 'Upper',
    'Lwr' => 'Lower',
    'Ctrl' => 'Central',
    'Ext' => 'Extension',
  }

  SUBURB_MAPPING = {
    # Suburbs
    'Mt' => 'Mount',
    'St' => 'Saint'
  }
  
  protected

  # Converts abbreviations to their long form, starting from the end until the
  # first non-matching word is found
  def full_form_street_address(address)
    words = address.split
    words.reverse.each do |word|
      word.gsub!(Regexp.union(STREET_MAPPING.keys), STREET_MAPPING) || break
    end
    words.join ' '
  end
end