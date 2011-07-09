require 'spec_helper'

describe Member do
  subject { Factory(:member) }

  let(:admin) { Factory(:admin) }

  it { should have_many :authentications }

  it { should have_one :address }

  it { should have_many :team_requests }
  it { should have_many :team_members }
  it { should have_many :team_mates }
  it { should have_many :teams }
  it { should have_one :owned_team }

  it { should have_many :role_members }
  it { should have_many :roles }

  it { should have_many :friendships }
  it { should have_many :friends }

  context 'User#full_name' do
    it 'should return the first and last name of the member' do
      member = Factory(:member, :first_name => 'Johnny', :last_name => 'Cage')
      member.full_name.should == 'Johnny Cage'
    end
  end

  context 'System Roles' do
    
  end

  context 'Roleable Roles' do # and potent potables
    
  end

  context 'Friendships' do

  end

  context 'Team Requests' do

  end
end