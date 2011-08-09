class Rink < ActiveRecord::Base
  DEFAULT_MISSING_OWNER_NAME = 'N/A'
  DEFAULT_MISSING_CONTACT_NAME = 'N/A'

  has_one :address, :as => :addressable, :dependent => :destroy
  belongs_to :owner, :class_name => 'Member'
  belongs_to :contact, :class_name => 'Member'

  #how to do
  #has_many :role_members, :as => :roleable, :dependent => :destroy

  attr_accessible :name, :address_attributes, :phone, :email, :website, :owner_name, :contact_name, :description
  accepts_nested_attributes_for :address

  validates_presence_of :name


  # ======================================
  # OWNER HELPERS
  # ======================================
  #TODO: add some metaprogramming here to refactor?
  def owner_name_set?
    (owner_name.nil? || owner_name.empty?)
  end

  def get_owner_name
    (!owner.nil?) ? owner.full_name
        : (owner_name_set? ? DEFAULT_MISSING_OWNER_NAME
        : owner_name)
  end

  def contact_name_set?
    (contact_name.nil? || contact_name.empty?)
  end

  def get_contact_name
    (!contact.nil?) ? contact.full_name
        : (contact_name_set? ? DEFAULT_MISSING_CONTACT_NAME
        : contact_name)
  end

  def owner=(member)
    if owner.is_a? Member
      self[:owner] = member       #how to avoid infinite loop?
      owner_name = member.full_name
    else
      owner_name= member
    end
    save
  end

  def contact=(member)
    if contact.is_a? Member
      self[:contact] = member
      contact_name = member.full_name
    else
      contact_name = member
    end
    save
  end


  # ======================================
  # CONTACTED/VERIFIED/REGISTERED HELPERS
  # ======================================
  # is there a better way to refactor these 'set' methods
  #  (I.E. maybe pass in the name of the general attribute)
  def set_contacted
    self.contacted = true
    self.original_contact_date = Time.now if self.original_contact_date.nil?
    self.last_contact_date = Time.now
  end

  def set_verified
    self.verified = true
    self.original_verified_date = Time.now if self.original_verified_date.nil?
    self.last_verified_date = Time.now
  end

  def set_registered
    self.register_date = Time.now
  end

  #needed to spit out the JSON for the map of rinks
  def as_json(options = {})
  { :id  => id,
    :name => name,
    :address => 'address',
    :latitude  => address.latitude.to_s,
    :longitude => address.longitude.to_s }
  end

  # this method is to help when pulling the rinks in
  # originally through the YAML Fixture
  #
  # for some reason the YAML methods were not getting
  # parsed correctly and did not include addresses
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