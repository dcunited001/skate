class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true


  validates :state, :presence => true, :format => {:with => /^[A-Z]{2}$/, :message => "must be an uppercase two letter abbreviation"}
  validates :zip, :presence => true, :format => {:with => /^\d{5}([\-]?\d{4})?$/, :message => "must be a valid US zipcode"}

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

