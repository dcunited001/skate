class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #for omniauth
  #has_many :authentications

  has_many :role_members
  has_many :roles, :through => :role_members

  has_one :address, :as => :addressable, :dependent => :destroy
  belongs_to :rink, :foreign_key => :homerink_id

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  accepts_nested_attributes_for :address

  after_create :add_basic_member_role

  def add_basic_member_role
    roles << AppRole.find_by_name(Role::MEMBER)
  end

  #retrieve roles
  def role_symbols
    roles.map do |role|
      role.name.to_sym
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
