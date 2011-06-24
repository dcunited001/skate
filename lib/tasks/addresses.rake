namespace :addresses do
  desc "attempt to geocode addresses"
  task :geocode => :environment do
    puts "Reading rinks from database"

  #while (Address.where("latitude = -1 or longitude = -1"))do
  
    uncoded = Address.where("latitude = -100.00 or longitude = -200.00")

    uncoded.each {|a|
      puts a.to_s
      code = Geokit::Geocoders::GoogleGeocoder.geocode a.to_s

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

