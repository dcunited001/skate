require 'spec_helper'

describe Team do
  subject { Factory(:team) }

  it { should belong_to :creator }
  it { should belong_to :rink }

  it { should validate_presence_of :name }

  context 'Creator' do
    before do

    end

    it 'can get and set the team\'s creator and his/her roles' do
      pending
    end
  end

  context 'Team Requests' do
    before do

    end

    it 'can list all pending Team Requests' do
      pending
    end

    it 'can list all accepted Team Requests' do
      pending
    end

    it 'can list all rejected Team Requests' do
      pending
    end
  end

  context 'Team Members' do
    before do

    end

    it 'should list the current active team members' do
      pending
    end

    it 'should list the current active team captains' do
      pending
    end
  end
end
