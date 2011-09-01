module SqlLoader
  class Messages
    def self.create_msg
      { :start => 'Creating objects for',
        :error => 'Encountered errors creating objects:',
        :no_error => 'All objects created successfully!',
        :delimiter => '=================================' }
    end

    def self.drop_msg
        {:start => 'Dropping objects for',
        :error => 'Encountered errors dropping objects:',
        :no_error => 'All objects dropped successfully!',
        :delimiter => '================================='}
    end
  end
end