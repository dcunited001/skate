class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true


  validates :state, :presence => true, :format => {:with => /^[A-Z]{2}$/, :message => "must be an uppercase two letter abbreviation"}
  validates :zip, :presence => true, :format => {:with => /^\d{5}([\-]\d{4})?$/, :message => "must be a valid US zipcode"}

#  validates_format_of :zip, :with => /^[0-9]{5}/i, :message => "ZIP code must be 5 digits"
#  validates_format_of :state, :with => /^[a-zA-Z]{2}$/i, :message => "Must be a valid State"

  validates_presence_of :city, :line_one

  def to_s
    if line_two
      "#{line_one} #{line_two} #{city}, #{state} #{zip}"
    else
      "#{line_one} #{city}, #{state} #{zip}"
    end
  end
end

# ADDRESSES ============================
# TODO: add validation(state, zip, cityexists, at least line_one populated)
# TODO: write tests for validations
# TODO: select state from drop down

