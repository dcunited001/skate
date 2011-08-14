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
      @team_creator.is_teamcreator_of?(subject).should_not be_true
      subject.creator.should be @new_creator
      subject.original_creator.should be @team_creator

      # need to test that a team's creator can be changed several times
      #   and that it won't affect the team members returned
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

      pending 'need to implement INSERT rule for team_captains view'
    end

    it 'can add the team creator as a team captain as well' do
      @team_creator.is_teamcreator_of?(subject).should be_true
      @team_creator.is_teamcaptain_of?(subject).should be_false

      (subject.teamcaptains << @team_creator).should be_true
      @team_creator.is_teammember?.should be_true
      @team_creator.is_teamcaptain?.should be_true
      @team_creator.is_teamcreator?.should be_true

      pending 'need to implement INSERT rule for team_captains view'
    end

    it 'throws an exception when attempting to add a team captain that is not a member' do
      pending 'postgres view, rules, etc. also need to figure out best way to throw exceptions'
    end

  end


  context 'Team Members' do
    before(:all) do
      #jammers-va
      @dcunited = Factory(:admin, :alias => 'dcunited001')
      @xm_jester_mx = Factory(:member, :alias => 'xm-Jester-mx')
      @cooper = Factory(:member, :alias => 'cory-coopster')

      #authentic_freaks
      @quinton = Factory(:member, :alias => 'quinton')
      @james = Factory(:member, :alias => 'anaconda')
      @brandon = Factory(:member, :alias => 'bb_sk8r')

      @jammers_va = Factory(:team, :name => 'Jammers VA', :creator => @dcunited)
      Factory(:team_member, :team => @jammers_va, :member_requesting => @dcunited, :member_requested => @xm_jester_mx)
      Factory(:team_member_from, :team => @jammers_va, :member_requesting => @cooper, :member_requested => @dcunited)

      @authentic = Factory(:team, :name => 'Authentic Freaks', :creator => @james)
      Factory(:team_member, :team => @authentic, :member_requesting => @james, :member_requested => @quinton)
      Factory(:team_member_from, :team => @authentic, :member_requesting => @brandon, :member_requested => @james)

      #set up some outstanding team requests
      @admin_req_from_jammers = Factory(:admin);          Factory(:team_request, :team => @jammers_va, :member_requesting => @dcunited,:member_requested => @admin_req_from_jammers)
      @skater_req_to_jammers = Factory(:member);          Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_req_to_jammers,:member_requested => @dcunited)
      @skater_req_from_jammers = Factory(:member);        Factory(:team_request, :team => @jammers_va, :member_requesting => @dcunited, :member_requested => @skater_req_from_jammers)
      @skater_req_to_authentic = Factory(:member);        Factory(:team_request, :team => @authentic, :member_requesting => @skater_req_to_authentic,:member_requested => @james)
      @skater_req_from_authentic = Factory(:member);      Factory(:team_request, :team => @authentic, :member_requesting => @james,:member_requested => @skater_req_from_authentic)
      @skater_req_from_authentic_two = Factory(:member);  Factory(:team_request, :team => @authentic, :member_requesting => @james,:member_requested => @skater_req_from_authentic_two)
    end

    it 'should assign the teammember role' do
      @dcunited.is_appadmin?.should be_true
      @dcunited.is_teammember_of?(@jammers_va).should be_true

      @xm_jester_mx.is_teammember_of?(@jammers_va).should be_true
      @xm_jester_mx.is_teammember_of?(@authentic).should be_false

      @quinton.is_teammember_of?(@authentic).should be_true
      @quinton.is_teammember_of?(@authentic).should be_false

      @james.is_teammember_of?(@authentic).should be_true

      @admin_req_from_jammers.is_appadmin?.should be_true
      @admin_req_from_jammers.is_teammember_of?(@jammers_va).should be_false
      @skater_req_from_jammers.is_teammember_of?(@jammers_va).should be_false
      @skater_req_to_authentic.is_teammember_of?(@authentic).should be_false
      @skater_req_to_authentic_two.is_teammember_of?(@authentic).should be_false
    end

    it 'should assign the teamcreator role' do
      @dcunited.is_teamcreator_of?(@jammers_va).should be_true
      @dcunited.is_teamcreator_of?(@authentic).should be_false

      @quinton.is_teamcreator_of?(@authentic).should be_false

      @james.is_teamcreator_of?(@authentic).should be_true
      @james.is_teamcreator_of?(@jammers_va).should be_false
    end

    it 'should list the current active team members' do
      @jammers_va.team_members.count.should == 3
      @authentic.team_members.count.should == 3

      @jammers_va.team_members.should include(@dcunited)
      @jammers_va.team_members.should include(@xm_jester_mx)
      @jammers_va.team_members.should_not include(@james)

      @authentic.team_members.should include(@james)
      @authentic.team_members.should include(@quinton)
      @authentic.team_members.should_not include(@quinton)
    end

    it 'should be able to quickly tell if a given member is on the team or not' do
      pending 'method implementation'

      @jammers_va.has_member?(@dcunited).should be_true
      @jammers_va.has_member?(@james).should be_false
      @jammers_va.has_member?(@admin_req_from_jammers).should be_false

      @authentic.has_member?(@dcunited).should be_false
      @authentic.has_member?(@quinton).should be_true
      @authentic.has_member?(@skater_req_to_authentic).should be_true
    end

    context 'and Team Captains' do
      before(:all) do
        #set up some team captains
      end

      it 'should list the current active team captains' do

      end

      it 'should promote members to team captains' do

      end

      it 'should promote team creators to team captains' do

      end

      it 'should demote captains to members' do

      end

      it 'should demote team creators to captains and maintain the correct roles' do

      end

      it 'should not promote to captain any members of another team or non-members' do

      end

      it 'should not demote from captain any non-captains or captains of another team' do

      end
    end
  end
end
