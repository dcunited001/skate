 require 'geokit'

  uncoded = [{ :line_one => "4121 Brandon Ave", :city => "Roanoke", :state => "VA", :zip => "24018" },
    { :line_one => "426 N. Market St.", :city => "Salem", :state => "VA", :zip => "24153" },
  { :line_one => "332131 faafafdsasandon ttse", :city => "fffdsaoke", :state => "VA", :zip => "24518" },
  { :line_one => "332131 fffafdsasandon ttse", :city => "ffffdsaoke", :state => "VA", :zip => "" }]

uncoded.each {|a|
    puts a[:line_one] + " " + a[:city] + ", " + a[:state] + " " + a[:zip]

    #different address line formats?
    address_line = a[:line_one] + " " + a[:city] + ", " + a[:state] + " " + a[:zip]

    code = ""
    code = Geokit::Geocoders::YahooGeocoder.geocode address_line
    puts code.lat
    puts code.lng
    puts ""

    sleep 1
  }