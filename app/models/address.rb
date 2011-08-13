class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  #WHAT TO CALL THIS FIELD??
  belongs_to :real_state, :foreign_key => :state, :primary_key => :abbrev, :class_name => 'State'

  attr_accessible :line_one, :line_two, :city, :state, :zip

  validates_presence_of :city, :line_one
  validates :state, :presence => true, :format => {:with => /^[A-Z]{2}$/, :message => "must be an uppercase two letter abbreviation"}
  validates :zip, :presence => true, :format => {:with => /^\d{5}([\-]?\d{4})?$/, :message => "must be a valid US zipcode"}

  def to_s
    "#{line_one} #{(line_two + ' ') if !(line_two.nil? or line_two.empty)}#{city}, #{state} #{zip}"
  end

  def as_hash
    {
      :line_one => self.line_one,
      :line_two => self.line_two,
      :city => self.city,
      :state => self.state,
      :zip => self.zip,
      :latitude => self.latitude.to_f,
      :longitude => self.longitude.to_f
    }
  end
end