namespace :addresses do
  desc "attempt to geocode addresses"
  task :geocode => :environment do
    puts "Reading rinks from database"

  #while (Address.where("latitude = -1 or longitude = -1"))do
  
    uncoded = Address.where("latitude = -100.00 or longitude = -200.00")

    uncoded.each {|a|
      puts a[:line_one] + " " + a[:city] + ", " + a[:state] + " " + a[:zip]

      #different address line formats?
      address_line = a[:line_one] + " " + a[:city] + ", " + a[:state] + " " + a[:zip]

      code = ""
      code = Geokit::Geocoders::GoogleGeocoder.geocode address_line

      a.latitude = code.lat
      a.longitude = code.lng
      a.save

      puts code.lat
      puts code.lng
      puts ""

      sleep 0.25
    }
    end

  #end
end

