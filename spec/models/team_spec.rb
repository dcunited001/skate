require 'spec_helper'

describe Team do
  @team_creator = Factory(:member)
  subject { Factory(:team, :creator => @team_creator) }

  it { should belong_to :creator }
  it { should belong_to :rink }

  it { should validate_presence_of :name }

  context 'with a Creator and Captains' do
    before do
      @team_captian = Factory(:member)
    end

    # Do i really need to test this?
    it 'can get and set the team\'s creator and roles are added and removed appropriately' do
      @team_creator.is_teamcreator_of?(subject).should be_true

      @new_creator = Factory(:member)
      subject.set_creator @new_creator

      @new_creator.is_teamcreator_of?(subject).should be_true
      subject.creator.should be @new_creator
    end

    it 'can get and set the team\'s captains and roles are added and removed appropriately' do
      pending 'need to create the team members view, test that out.  also need to create the postgres rules'
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

    it 'should list the current active team devise' do
      pending
    end

    it 'should list the current active team captains' do
      pending
    end
  end
end
