#this is way too fragile, but I'm not sure
#   how to specify the order in which objects are created/dropped
#   short of creating a configuration yaml file that
#   specifies the dependencies between each object

#there's probably a million better ways to do this
#   but it's my first time creating a module like this,
#   sue me

#the naming convention for sql files is very specific
#   tables: table_model_names.sql
#   view:   view_model_names.sql
#   rules:  rule_target_view_action (target view is what it sounds like, action is either insert update or delete)
#
#   everything else is to be implemented

#the order in which scripts are ran (for each object type)
#   1. tables
#   2. views
#   3. functions
#   4. indexes
#   5. rules

#the order is reversed when dropping objects

module SqlLoader
  require Rails.root.join('db', 'sql_loader', 'lib', 'messages.rb')

  class SqlLoaderBase
    @@debug = false

    @@messages = {
        :create => SqlLoader::Messages.create_msg,
        :drop => SqlLoader::Messages.drop_msg }

    CREATE_START = 'Creating objects for'
    CREATE_ERRORS = 'Encountered errors creating objects:'
    CREATE_DELIMETER = '================================='
    NO_CREATE_ERRORS = 'All objects created successfully!'

    DROP_START = 'Dropping objects for'
    DROP_ERRORS = 'Encountered errors dropping objects:'
    DROP_DELIMETER = '================================='
    NO_DROP_ERRORS = 'All objects dropped successfully!'

    SQL_LOADER_ROOT = File.join(Rails.root, 'db/sql_loader')
    Dir[File.join(SQL_LOADER_ROOT, "*.rb")].each {|rb| require rb }

    #order is important here,
    #   as their objects will be created in order
    #   and dropped in reverse order
    def self.all_classes
      [Member,
      Friend,
      TeamMember,
      TeamMate,
      TeamCaptain]

      #Need to change this implementation to catch errors
      #   for multiple classes, instead of blowing up
      #   after the first class

      # I'd really like to add more load options later
    end

    def self.create_all
      # i finally feel cool enough to spell class with a "k"
      all_classes.each {|klass| klass.create}
    end

    def self.drop_all
      all_classes.reverse.each {|klass| klass.drop}
    end

    def self.relative_name
      name.to_s.split('::').last
    end

    def self.get_sql_files
      #for each type, append it's sql files into an array in an order that can be executed
      sql_object_types = %w[table view function index rule]

      sql_object_types.each_with_object([]) do |type, files|
        files.concat(Dir[File.join(SQL_LOADER_ROOT, relative_name.underscore, "#{type}_*.sql")])
      end
    end

    def self.create
      errors = []

      puts "#{@@messages[:create][:start]} #{relative_name}" if @@debug

      get_sql_files.each do |sql|
        begin
          ActiveRecord::Base.connection.execute(IO.read(sql))
        rescue
          errors << $!
        end
      end

      create_error_output(errors)
    end

    def self.drop
      errors = []

      puts "#{@@messages[:drop][:start]} #{relative_name}" if @@debug

      get_sql_files.reverse.each do |f|
        sql = drop_statement(f)

        begin
          ActiveRecord::Base.connection.execute(sql)
        rescue
          errors << $!
        end
      end

      drop_error_output(errors)
    end

    def self.drop_statement(filename)
      case File.basename(filename, '.sql')
        when /(^table.*)/i
          return "DROP TABLE IF EXISTS #{$1};"
        when /(^view.*)/i
          return "DROP VIEW IF EXISTS #{$1};"
        when /(^rule_(.*)_(insert|delete|update))/i
          return "DROP RULE IF EXISTS #{$1} ON #{$2};"
      end
    end

    # ERROR OUTPUT

    def self.create_error_output errors
      out = "Creating #{relative_name} Objects: "

      if errors.any?
        out += "#{@@messages[:create][:error]}\n"
        errors.each {|e| out += "\n\n#{@@messages[:create][:delimiter]}\n#{e}\n" }

        puts out
        raise "SqlLoader Exception"
      else
        out += @@messages[:create][:no_error]
        puts out if @@debug
      end
    end

    def self.drop_error_output errors
      out = "Dropping #{relative_name} Objects: "

      if errors.any?
        out += "#{@@messages[:drop][:error]}\n"
        errors.each {|e| out += "\n\n#{@@messages[:drop][:delimiter]}\n#{e}\n" }

        puts out
        raise "SqlLoader Exception"
      else
        out += @@messages[:drop][:no_error]
        puts out if @@debug
      end
    end
  end
end