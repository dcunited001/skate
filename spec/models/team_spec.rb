require 'spec_helper'

describe Team do
  @team_creator = Factory(:member)
  subject { Factory(:team, :creator => @team_creator) }

  it { should belong_to :creator }
  it { should belong_to :rink }

  it { should validate_presence_of :name }

  context 'with a Creator and Captains' do
    before do
      @team_captain = Factory(:member)
    end

    # Do i really need to test this?
    it 'can get and set the team\'s creator and roles are added and removed appropriately' do
      @team_creator.is_teamcreator_of?(subject).should be_true

      @new_creator = Factory(:member)
      subject.set_creator @new_creator

      @new_creator.is_teamcreator_of?(subject).should be_true
      subject.creator.should be @new_creator
    end

    it 'can add a member as a team captain, only if they are already members of the team' do
      @team_captain.is_teammember_of?(subject).should be_false
      @team_captain.is_teamcaptain_of?(subject).should be_false

      #try to add a team_captain before they are members and it should return false
      (subject.teamcaptains << @team_captain).should be_false

      (subject.teammembers << @team_captain).should be_true
      @team_captain.is_team_member?.should be_true
      @team_captain.is_teamcaptain?.should be_false

      (subject.teamcaptains << @team_captain).should be_false
      @team_captain.is_team_member?.should be_true
      @team_captain.is_teamcaptain?.should be_true

      pending 'need to create the team members view, test that out.  also need to create the postgres rules'
    end

    it 'can add the team creator as a team captain as well' do
      @team_creator.is_teamcreator_of?(subject).should be_true
      @team_creator.is_teamcaptain_of?(subject).should be_false

      (subject.teamcaptains << @team_creator).should be_true
      @team_creator.is_teammember?.should be_true
      @team_creator.is_teamcaptain?.should be_true
      @team_creator.is_teamcreator?.should be_true

      pending 'need to create the team members view, test that out.  also need to create the postgres rules'
    end

    it 'throws an exception when attempting to add a team captain that is not a member' do
      pending 'postgres view, rules, etc.  also need to figure out best way to throw exceptions'
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

    it 'should be able to quickly tell if a given member is on the team or not' do

    end
  end
end
