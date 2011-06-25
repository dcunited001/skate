

# RINKS MODEL ====================
# TODO: Add validations?
# TODO: Complete Named Scopes
# TODO: set rink employees



class Rink < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy

  belongs_to :owner, :class_name => 'Member'
  belongs_to :contact, :class_name => 'Member'

  has_many :role_members, :as => :roleable, :dependent => :destroy

  accepts_nested_attributes_for :address

  attr_accessible :name, :address_attributes, :phone, :email, :website, :owner_name, :contact_name, :description

  validates_presence_of :name

  #NAMED SCOPES
  #   all_visible
  #   all_invisible
  #   all_verified
  #   all_unverified
  #   all_sanctioned
  #   all_unsanctioned
  #   all_contacted
  #   all_uncontacted
  #   verified_last_week
  #   verified_last_month
  #   sanctioned_last_week
  #   sanctioned_last_month
  #   contacted_last_week
  #   contacted_last_month
  #   with_teams
  #   without_teams
  #   with_members
  #   without_members
  #   with_active_members
  #   without_active_members

  def as_json(options = {})
  { :id  => id,
    :name => name,
    :address => 'address',
    :latitude  => address.latitude.to_s,
    :longitude => address.longitude.to_s }
  end

  def display_owner
    if owner_id > 0 then
      owner_id
    elsif (owner_name.nil? || owner_name.empty?)
      'N/A'
    else
      owner_name
    end
  end

  def is_owner_set?
    (owner_id > 0) || (!owner_name.nil? && !owner_name.empty?)
    #if (owner_id > 0) || ()
  end

  def set_contacted
    self.contacted = true
    self.original_contact_date = Time.now if self.original_contact_date.nil?
    self.last_contact_date = Time.now
  end

  def set_verified
    self.verified = true
    self.original_verify_date = Time.now if self.original_verify_date.nil?
    self.last_verify_date = Time.now
  end

  def set_registered
    self.register_date = Time.now
  end

  def as_hash
    {
      :name => self.name,
      :phone => self.phone,
      :website => self.website,
      :email => self.email,
      :owner_name => self.owner_name,
      :owner_id => self.owner_id,
      :contacted => self.contacted,
      :original_contact_date => self.original_contact_date,
      :last_contact_date => self.last_contact_date,
      :contact_name => self.contact_name,
      :contact_id => self.contact_id,
      :register_date => self.register_date,
      :visible  => self.visible,
      :verified  => self.verified,
      :original_verified_date => self.original_verified_date,
      :last_verified_date => self.last_verified_date,
      :sanctioned => self.sanctioned,
      :original_sanction_date  => self.original_sanction_date,
      :last_sanction_date => self.last_sanction_date,
      :description => self.description,
      :allow_comments => self.allow_comments,

      :address => {
          :line_one => self.address.line_one,
          :line_two => self.address.line_two,
          :city => self.address.city,
          :state => self.address.state,
          :zip => self.address.zip,
          :latitude => self.address.latitude.to_f,
          :longitude => self.address.longitude.to_f
      }
    }
  end
end


# RINKS ================================
# TODO: validations
# TODO: write rink tests: create rink (with address)
# TODO: write rink tests: delete rink (destroy address
# TODO: write rink tests: change rink address
# TODO: make rateable?
# TODO: make commentable


# MAPS =================================
# TODO: look up maps mashup tutorials
# TODO: install gems for google maps mashup
# TODO: install gems for geocoding
# TODO: rake task to geocode addresses
# TODO: get google maps api key
# TODO: teams map
# TODO: rink map
# TODO: upcoming events map




# MAPS GUIDES
#
#    maps v3 demos (and forum)
#    http://code.google.com/apis/maps/documentation/javascript/demogallery.html
#
#    Geocoder Demo
#    http://gmaps-samples-v3.googlecode.com/svn/trunk/geocoder/v3-geocoder-tool.html#q%3D11.049038%2C-7.470703
#
#    Marker Clusterer
#    http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerclusterer/1.0/examples/advanced_example.html
#
#    Solutions to "Too Many Markers"
#    http://gmaps-samples-v3.googlecode.com/svn/trunk/toomanymarkers/toomanymarkers.html
#
#    Rails, GeoKit, YM4R/GM
#    http://www.javabeat.net/articles/144-ruby-on-rails-web-mashup-projects-1.html
#
#    YM4R
#    http://allaboutruby.wordpress.com/?s=ym4r&searchbutton=Go!
#
#    cartographer plugin for rails
#    https://github.com/parolkar/cartographer
#
#    Add points with AJAX
#    http://marcgrabanski.com/articles/jquery-google-maps-tutorial-ajax-php-mysql
#
#    Google Maps Interaction with AJAX events
#    http://articles.sitepoint.com/article/google-maps-api-jquery

