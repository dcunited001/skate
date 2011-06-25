  namespace :rinks do
    desc "delete all rinks in the database"
    task :delete => :environment do
      Rink.delete_all
    end

    desc "write rinks to YAML file"
    task :to_yaml, :file_name, :needs => :environment do |t, args|

      file_name = 'rinks.yml'
      file_name = args[:file_name] if args[:file_name]

      file = File.open(File.join(Rails.root, 'db/seeds', file_name),"w+")
      rinks = Rink.all.collect { |r| r.as_hash }
      if file
         file.syswrite(rinks.to_yaml)
      else
         puts "Unable to open file!"
      end
    end

    #TODO: this rake task is not necessary
    desc "upload rinks from YAML file"
    task :upload => :environment  do
      all_rinks = YAML.load(File.open("lib/tasks/rinks.yml"))

      this_rink = nil
      addy = nil
      all_rinks.each_pair { |key,value|
        this_rink = Rink.new

        #values from hash
        this_rink.name = value['name']
        this_rink.phone = value['phone']
        this_rink.website = value['website']
        this_rink.email = value['email']
        this_rink.description = value['description']

        #create new address and attach
        addy = value['address']
        this_addy = Address.new
        this_addy.line_one = addy['line_one']
        this_addy.line_two = addy['line_two']
        this_addy.city = addy['city']
        this_addy.state = addy['state']
        this_addy.zip = addy['zip']
        this_rink.address = this_addy

        this_rink.save

        puts key
        puts value
      }


      team = Team.new
      team.name ='Jammers VA'
      team.rink = this_rink

      team_addy = Address.new
      team_addy.line_one = addy['line_one']
      team_addy.line_two = addy['line_two']
      team_addy.city = addy['city']
      team_addy.state = addy['state']
      team_addy.zip = addy['zip']
      team.address = team_addy

      team.save
    end

    desc "output all rinks in the database to CSV format"
    task :csv => :environment do
      puts "Reading rinks from database"
      rinks = Rink.all(:include => :address)

      puts "opening rinks.csv"

      file = File.new("rinks.csv", "w+")
      if file
        file.puts "ID, Rinkname, Phone, Email, Website, LineOne, LineTwo, City, State, Zip, Description"

        rinks.each { |r|
          puts  r.name

          file.puts r.id.to_s + ',' +
            r.name.gsub(",", "") + ',' +
            r.phone + "," +
            r.email + "," +
            r.website + "," +
            r.address.line_one + "," +
            r.address.line_two + "," +
            r.address.city + "," +
            r.address.state + "," +
            r.address.zip + "," +
            r.description
        }

      else
         puts "Unable to open file!"
      end
    end

    
  end