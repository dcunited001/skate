class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  validates_presence_of :city, :line_one
  validates :state, :presence => true, :format => {:with => /^[A-Z]{2}$/, :message => "must be an uppercase two letter abbreviation"}
  validates :zip, :presence => true, :format => {:with => /^\d{5}([\-]?\d{4})?$/, :message => "must be a valid US zipcode"}

  def to_s
    "#{line_one} #{(line_two + ' ') if !line_two.empty?} #{city}, #{state} #{zip}"
  end
end