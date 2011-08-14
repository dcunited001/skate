require 'spec_helper'

describe TeamMember do
  it { should belong_to :member_requesting }
  it { should belong_to :member_requested }

  it { should belong_to :team }

  context 'Request Rules' do
    before do
      @member = Factory(:member)

      @team_creator = Factory(:team_creator)
      @team_member = Factory(:team_member, :team => @team_creator.team)
    end

    it 'knows if the member requested is already on a team' do
      pending
    end

    it 'knows if the member requested is already requested by a specific member' do
      pending
    end

    it 'knows if the member requested has already requested to be on a specific team' do
      pending
    end

    it 'knows if the member requested has already received a request to be on a specific team' do
      pending
    end
  end

  context 'Request Scopes' do
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
      end

      before(:each) do
        @skater_pending_from_jammers = Factory(:member);    @req_skater_pending_from_jammers = Factory(:team_request, :team => @jammers_va, :member_requesting => @dcunited,:member_requested => @skater_pending_from_jammers)
        @skater_pending_to_jammers = Factory(:member);      @req_skater_pending_to_jammers = Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_pending_to_jammers,:member_requested => @dcunited)
        @skater_pending_to_jammers_two = Factory(:member);  @req_skater_pending_to_jammers_two = Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_pending_to_jammers_two,:member_requested => @dcunited)
        @skater_pending_to_authentic = Factory(:member);    @req_skater_pending_to_authentic = Factory(:team_request, :team => @authentic, :member_requesting => @skater_pending_to_authentic ,:member_requested => @james)
        @skater_not_gonna_be_on_jammers = Factory(:member); @req_skater_not_gonna_be_on_jammers = Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_not_gonna_be_on_jammers ,:member_requested => @dcunited)
      end

      it 'can list all Pending Team Requests' do
        @jammers_va.team_requests.pending.should include(@req_skater_pending_from_jammers, @skater_pending_to_jammers, @req_skater_not_gonna_be_on_jammers)
        @jammers_va.team_requests.pending.should_not include(@req_skater_pending_to_authentic)
        @authentic.team_requests.pending.should include(@req_skater_pending_to_authentic)

        @jammers_va.team_requests.pending.to_team.should include(@skater_pending_to_jammers)
        @jammers_va.team_requests.pending.to_team.should_not include(@req_skater_pending_from_jammers)
        @jammers_va.team_requests.pending.from_team.should include(@req_skater_pending_from_jammers)
      end

      it 'can list all Accepted Team Requests' do


        #even after a team member is removed, it should still show as accepted
      end

      it 'can list all Rejected Team Requests' do

        #rejected team requests should not include members that quit or were kicked off
      end

      it 'can list all Ended Team Memberships' do

      end
    end
  end

  context 'Request Action Helpers' do
    before do

    end

    it 'can be approved if valid' do
      #necessary to check validity here because member may have joined a team after the request was sent

      pending
    end

    it 'can be rejected if valid' do
      pending
    end
  end
end